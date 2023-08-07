import matplotlib.pyplot as plt
import numpy as np

# Given data points
x = [1, 2, 3, 4, 5, 6, 7]
y = [190634, 118543, 86292, 64668, 51736, 46698, 43160]

# Create a range of x-values for the continuous function
x_continuous = np.linspace(min(x), max(x), 100)

# Interpolate the function using numpy's interp
y_continuous = np.interp(x_continuous, x, y)

# Plot the data points as a scatter plot with customizations
plt.figure(figsize=(8, 6))  # Set the size of the figure
plt.scatter(x, y, color='red', label='Data Points', marker='o', s=80)  # Use circles for markers

# Plot the continuous function as a line
plt.plot(x_continuous, y_continuous, label='Continuous Function', linestyle='--', linewidth=2)

plt.xlabel('instances', fontsize=14)  # Set the label and its font size for the x-axis
plt.ylabel('latency', fontsize=14)  # Set the label and its font size for the y-axis
plt.title('Plot of latency with instances', fontsize=16)  # Set the title and its font size
plt.grid(True, linestyle='--', alpha=0.7)  # Add grid lines with a dashed style and reduced opacity
plt.legend(fontsize=12)  # Set the legend font size

# Customizing the tick labels on both axes
plt.xticks(x, fontsize=12)  # Set custom x-axis tick labels using the values in the 'x' list
plt.yticks(fontsize=12)  # Set the font size of y-axis tick labels

# Adding a background color to the plot
ax = plt.gca()
ax.set_facecolor('#f0f0f0')  # Choose any color you like

# Adding annotations for each point with the values
for i, txt in enumerate(y):
    plt.annotate(txt, (x[i], y[i]), textcoords="offset points", xytext=(5, 5), ha='center', fontsize=10)
    plt.annotate(f"({x[i]}, {y[i]})", (x[i], y[i]), textcoords="offset points", xytext=(-15, -20), ha='center', fontsize=8, color='blue')

# Display the plot (optional, you can save it to a file if you prefer)
plt.tight_layout()  # Adjust spacing for a cleaner look
plt.show()


# Given data points
x = [1, 2, 3, 4, 5, 6, 7]
y = [67, 205, 239, 358, 447, 539, 628]

# Create a range of x-values for the continuous function
x_continuous = np.linspace(min(x), max(x), 100)

# Interpolate the function using numpy's interp
y_continuous = np.interp(x_continuous, x, y)

# Plot the data points as a scatter plot with customizations
plt.figure(figsize=(8, 6))  # Set the size of the figure
plt.scatter(x, y, color='red', label='Data Points', marker='o', s=80)  # Use circles for markers

# Plot the continuous function as a line
plt.plot(x_continuous, y_continuous, label='Continuous Function', linestyle='--', linewidth=2)

plt.xlabel('instances', fontsize=14)  # Set the label and its font size for the x-axis
plt.ylabel('utilization', fontsize=14)  # Set the label and its font size for the y-axis
plt.title('Plot of utilization with instances', fontsize=16)  # Set the title and its font size
plt.grid(True, linestyle='--', alpha=0.7)  # Add grid lines with a dashed style and reduced opacity
plt.legend(fontsize=12)  # Set the legend font size

# Customizing the tick labels on both axes
plt.xticks(x, fontsize=12)  # Set custom x-axis tick labels using the values in the 'x' list
plt.yticks(fontsize=12)  # Set the font size of y-axis tick labels

# Adding a background color to the plot
ax = plt.gca()
ax.set_facecolor('#f0f0f0')  # Choose any color you like

# Adding annotations for each point with the values
for i, txt in enumerate(y):
    plt.annotate(txt, (x[i], y[i]), textcoords="offset points", xytext=(5, 5), ha='center', fontsize=10)
    plt.annotate(f"({x[i]}, {y[i]})", (x[i], y[i]), textcoords="offset points", xytext=(-15, -20), ha='center', fontsize=8, color='blue')

# Display the plot (optional, you can save it to a file if you prefer)
plt.tight_layout()  # Adjust spacing for a cleaner look
plt.show()


# i=1 BRAM=0 DSP=29 FF = 8 LUT =30
# i=2 BRAM=54 DSP=59 FF =20 LUT =72
# i=3 BRAM=40 DSP=90 FF =31 LUT =108
# i=4 BRAM=54 DSP=120 FF =41 LUT =141
# i=5 BRAM=67 DSP=150 FF =52 LUT =178
# i=6 BRAM=81 DSP=181 FF =63 LUT =214
# i=7 BRAM=96 DSP=211 FF =73 LUT =249

import matplotlib.pyplot as plt

# Given data
i_values = [1, 2, 3, 4, 5, 6, 7]
BRAM_values = [0, 54, 40, 54, 67, 81, 96]
DSP_values = [29, 59, 90, 120, 150, 181, 211]
FF_values = [8, 20, 31, 41, 52, 63, 73]
LUT_values = [30, 72, 108, 141, 178, 214, 249]

# Create the bar plot
plt.figure(figsize=(10, 6))  # Set the size of the figure
bar_width = 0.2  # Set the width of the bars

# Shift the x positions for each set of bars to prevent overlap
bar_positions_i = [i for i in range(len(i_values))]
bar_positions_BRAM = [pos + bar_width for pos in bar_positions_i]
bar_positions_DSP = [pos + 2 * bar_width for pos in bar_positions_i]
bar_positions_FF = [pos + 3 * bar_width for pos in bar_positions_i]

# Plot the bars for each value
plt.bar(bar_positions_i, BRAM_values, bar_width, label='BRAM')
plt.bar(bar_positions_DSP, DSP_values, bar_width, label='DSP')
plt.bar(bar_positions_FF, FF_values, bar_width, label='FF')
plt.bar(bar_positions_FF, LUT_values, bar_width, label='LUT', alpha=0.7)  # Add LUT bars with reduced opacity

plt.xlabel('instances', fontsize=14)  # Set the label and its font size for the x-axis
plt.ylabel('Utilization %', fontsize=14)  # Set the label and its font size for the y-axis
plt.title('Resource Utilization % for Different instances Values', fontsize=16)  # Set the title and its font size
plt.xticks(bar_positions_i, i_values)  # Set custom x-axis tick labels using the 'i_values' list
plt.legend(fontsize=12)  # Set the legend font size

# Display the plot (optional, you can save it to a file if you prefer)
plt.tight_layout()  # Adjust spacing for a cleaner look
plt.show()
