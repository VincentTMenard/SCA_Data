# Social Change Algorithm: Coups d'État and COVID-19 Analyses

This repository hosts the essential resources and scripts required for conducting analyses on Coups d'État and COVID-19 using the Social Change Algorithm. The repository is organized into two main sections: one for Coups d'État analysis and another for COVID-19 analysis. Below, you will find instructions on how to navigate through the repository and execute the analyses.

## Getting Started

To run the scripts and analyses contained in this repository, ensure you have MATLAB installed on your computer. Additionally, some analyses require SPSS for database generation. Please follow the setup instructions specific to each folder for detailed requirements.

### Directory Structure

- **Coups d'État**
  - **MATLAB**: Contains the script `figure_play_dynamic001.m` for performing the Coups d'État analysis. This script utilizes the data in `fichier_pays.txt`.
  - **Database**: Stores all necessary data files to generate the analysis database using SPSS software.

- **COVID-19**
  - **Analysis Scripts**: Contains scripts for conducting analyses on COVID-19 data for the USA and Canada. Use `Figure_play_dynamic03_COVID_Canada.m` for Canadian data analysis and `Figure_play_dynamic03_COVID_USA.m` for USA data analysis.
  - **Database**: Includes the database necessary for COVID-19 analysis.


## Running the Analyses

### Coups d'État Analysis

1. Navigate to the `Coups d'État/MATLAB` folder.
2. Open and run the `figure_play_dynamic001.m` script in MATLAB. Ensure `fichier_pays.txt` is in the same directory for the script to function properly.

### COVID-19 Analysis

1. Navigate to the `COVID-19` folder.
2. To analyze Canadian data, open and run `Figure_play_dynamic03_COVID_Canada.m` in MATLAB.
3. To analyze USA data, open and run `Figure_play_dynamic03_COVID_USA.m` in MATLAB.

## Prerequisites

- MATLAB (for running `.m` scripts)
- SPSS (for database generation in the Coups d'État analysis)

## Support

For any issues or questions regarding the repository or analyses, please open an issue in the GitHub repository or contact the repository maintainers directly.
