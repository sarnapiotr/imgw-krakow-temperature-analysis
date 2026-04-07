clear; close all; clc;

% Data selection

temperatures_cracow = zeros(14, 366);

for year = 2010:2023
    day_number = 1;

    for month = 1:12
        if month < 10
            file_name = "data/k_d_0" + month + "_" + year + ".csv";
        else
            file_name = "data/k_d_" + month + "_" + year + ".csv";
        end
        
        temp_table = readtable(file_name);
        temp_table_cracow = temp_table(string(temp_table.Var2) == "KRAKÓW-OBSERWATORIUM", :);

        [days_in_month, ~] = size(temp_table_cracow);
    
        year_index = year - 2009;
        for day = 1:days_in_month
            temperatures_cracow(year_index, day_number) = temp_table_cracow{day, 10};
            day_number = day_number + 1;
        end
    end
end

% Direct temperature plot

hold on;
for i = 1:14
    plot([1:366], temperatures_cracow(i, :));
end
hold off;
legend(string(2010:2023));
title("Average daily temperature - Krakow (2010 - 2023)");
xlabel("Day of the year");
ylabel("Temperature [°C]");
grid on;

% 3rd-degree polynomial approximation

figure;
hold on;

for i = 1:14
    coefficients = polyfit([1:366], temperatures_cracow(i, :), 3);
    y_fit = polyval(coefficients, [1:366]);
    plot([1:366], y_fit);
end
hold off;
legend(string(2010:2023));
title("3rd-degree polynomial approximation - Krakow (2010 - 2023)");
xlabel("Day of the year");
ylabel("Temperature [°C]");
grid on;