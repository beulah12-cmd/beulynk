#!/bin/bash
# Install Python dependencies
pip install -r requirements.txt

# Run migrations
python manage.py migrate

# Initialize NGO data
python manage.py init_ngo_data

