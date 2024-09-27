import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sqlalchemy import create_engine

# Set up the SQLAlchemy engine
engine = create_engine('oracle+cx_oracle://fes:admin@localhost:1521/?service_name=xe')

# Query to get data
query = """
SELECT 
    occupation,
    hours_per_week
FROM adult
"""

# Load data into a DataFrame
df = pd.read_sql(query, engine)

# Plotting
plt.figure(figsize=(12, 8))
sns.boxplot(x='occupation', y='hours_per_week', data=df)

# Set titles and labels
plt.title('Box Plot of Hours Worked by Occupation')
plt.xlabel('Occupation')
plt.ylabel('Hours Worked')
plt.xticks(rotation=45, ha='right')
plt.tight_layout()

plt.show()
