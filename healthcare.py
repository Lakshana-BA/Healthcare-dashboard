import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load data
data = pd.read_excel(r"C:/Users/laksh/Desktop/Healthcare/myenv/Healtcare-Dataset.xlsx")

# Ensure date columns are in datetime format
data['Admit_Date'] = pd.to_datetime(data['Admit_Date'])
data['Discharge_Date'] = pd.to_datetime(data['Discharge_Date'])

# Sidebar filters
st.sidebar.header('Filter Data')
selected_doctor = st.sidebar.selectbox('Select Doctor', options=data['Doctor'].unique())
selected_diagnosis = st.sidebar.selectbox('Select Diagnosis', options=data['Diagnosis'].unique())

# Filter data based on selection
filtered_data = data[(data['Doctor'] == selected_doctor) & (data['Diagnosis'] == selected_diagnosis)]

# **Main Dashboard**
st.title("🏥 Healthcare Dashboard")

# **Summary Metrics**
st.header("📊 Summary")
total_patients = filtered_data.shape[0]
avg_length_of_stay = (filtered_data['Discharge_Date'] - filtered_data['Admit_Date']).dt.days.mean()
total_billing = filtered_data['Billing Amount'].sum()

st.metric("Total Patients", total_patients)
st.metric("Avg. Length of Stay (Days)", round(avg_length_of_stay, 2))
st.metric("Total Billing", f"₹{total_billing:,.2f}")

# **Financial Overview**
st.header("💰 Financial Overview")
fig, ax = plt.subplots(figsize=(6, 4))
sns.barplot(data=filtered_data, x='Doctor', y='Billing Amount', hue='Health Insurance Amount',
            estimator=sum, ci=None, dodge=False, ax=ax)
ax.set_xticklabels(ax.get_xticklabels(), rotation=30, ha="right", fontsize=8)
st.pyplot(fig)

# **Test Breakdown**
st.header("🧪 Test Breakdown")
fig, ax = plt.subplots(figsize=(6, 4))
sns.countplot(data=filtered_data, x='Test', ax=ax)
ax.set_xticklabels(ax.get_xticklabels(), rotation=30, ha="right", fontsize=8)
st.pyplot(fig)

# **Diagnosis Breakdown**
st.header("🩺 Diagnosis Breakdown")
fig, ax = plt.subplots(figsize=(6, 4))
sns.countplot(data=filtered_data, x='Diagnosis', ax=ax)
ax.set_xticklabels(ax.get_xticklabels(), rotation=30, ha="right", fontsize=8)
st.pyplot(fig)
