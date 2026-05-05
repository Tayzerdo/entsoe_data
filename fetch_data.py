import pandas as pd
import requests
import os


import pandas as pd
import requests
import os

def get_entsoe_data(file_name):
    """
    Downloads monthly domestic power statistics from ENTSO-E for 2020-2025
    and saves them into a consolidated Parquet file.
    """
    years = range(2020, 2026)
    base_url = "https://www.entsoe.eu/publications/data/power-stats/{year}/{file_name}_{year}.xlsx"
    
    all_data = []

    for year in years:
        url = base_url.format(year=year, file_name=file_name)
        print(f"Attempting to fetch data for {file_name} - {year}...")
        
        try:
            # We use a stream to handle the download gracefully
            response = requests.get(url, timeout=15)
            
            if response.status_code == 200:
                # Read Excel directly from the response content in memory
                # Note: 'openpyxl' engine is required: pip install openpyxl
                df = pd.read_excel(response.content).astype(str)

                all_data.append(df)
                print(f"Successfully processed {year}")
            else:
                print(f"Skipping {year}: Server returned status {response.status_code}")
                
        except Exception as e:
            print(f"Error retrieving data for {year}: {e}")

        print("""

                """)

    # Combine and save
    if all_data:
        combined_df = pd.concat(all_data, ignore_index=True)
        
        # Clean up column names (Parquet prefers strings without spaces/special chars)
        combined_df.columns = [str(col).replace(" ", "_").lower() for col in combined_df.columns]
        
        file_path = f"data/{file_name}.parquet"
        combined_df.to_parquet(file_path, engine='pyarrow', index=False)
        print("-" * 30)
        print(f"Success! Saved {len(combined_df)} rows to {file_path}")
    else:
        print("No data was collected.")

if __name__ == "__main__":
    # Create the directory if it doesn't exist
    os.makedirs('data', exist_ok=True)
    get_entsoe_data("monthly_domestic_values")

    get_entsoe_data("physical_energy_power_flows")
    
    get_entsoe_data("net_generation_capacity")
    
    get_entsoe_data("inventory_of_generation")

    get_entsoe_data("inventory_of_transmission")