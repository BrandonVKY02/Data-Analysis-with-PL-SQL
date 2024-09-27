import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sqlalchemy import create_engine

# Set up the SQLAlchemy engine
engine = create_engine('oracle+cx_oracle://fes:admin@localhost:1521/?service_name=xe')

# Query to get data
query = """
SELECT race, occupation, COUNT(*) AS count
FROM adult
GROUP BY race, occupation
"""

# Load data into a DataFrame
df = pd.read_sql(query, engine)

# Create a pivot table
pivot_table = df.pivot(index='race', columns='occupation', values='count').fillna(0)

# Create a figure and axis object with a larger size
plt.figure(figsize=(14, 10))

# Create the heatmap
sns.heatmap(pivot_table, annot=True, fmt='g', cmap='YlGnBu', cbar=True)

# Set titles and labels
plt.title('Heatmap of Count of Occupation by Race')
plt.xlabel('Occupation')
plt.ylabel('Race')

# Rotate x-axis labels for better readability
plt.xticks(rotation=45, ha='right')

# Adjust layout to fit labels
plt.tight_layout()

# Show the plot
plt.show()
