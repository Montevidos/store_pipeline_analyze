import pandas as pd
import json
import requests 
from datetime import date
import boto3
from dotenv import load_dotenv
import os


def fetch_rio_weather_today(day):
    url = "https://archive-api.open-meteo.com/v1/archive"
    day_str = day.strftime("%Y-%m-%d")
    params = {
        "latitude": -22.90,
        "longitude": -43.19,
        "start_date": str(day_str),
        "end_date": str(day_str),
        "hourly": "temperature_2m,relative_humidity_2m,precipitation,surface_pressure,windspeed_10m",
        "timezone": "America/Sao_Paulo"
    }
    rio_data = requests.get(url, params=params).json()  
    return rio_data

def upload_rio_weather_to_s3(rio_data, day):
    day_str = day.strftime("%Y-%m-%d")
    key = f"weather/daily/rio_{day_str}.csv"
    S3_BUCKET = os.getenv("S3_BUCKET_NAME")
    s3 = boto3.client('s3') 
    rio = pd.DataFrame({"timestamp": rio_data['hourly']['time'],
                        "temperature_2m": rio_data['hourly']['temperature_2m'],
                        "relative_humidity_2m": rio_data['hourly']['relative_humidity_2m'],
                        "precipitation": rio_data['hourly']['precipitation'],
                        "surface_pressure": rio_data['hourly']['surface_pressure'],
                        "windspeed_10m": rio_data['hourly']['windspeed_10m']
                        })
    s3.put_object(
        Body=rio.to_csv(index=False),
        Bucket=S3_BUCKET,
        Key=key
    )
    return f"s3://{S3_BUCKET}/{key}"
