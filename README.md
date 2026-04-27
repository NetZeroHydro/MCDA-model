# Assessing impact of future hydropower using Multi-Criteria Decision Analysis Model

## Weighted-Sum Model

**Authors:** Leela Dixit, Megan Hessel, Aakriti Poudel, and Lucian Scher

### Purpose

This repository holds the function, testing, and sensitivity analysis for the MCDA model evaluating global future dams.

### Data

The function does not require any particular data. For this project, we used Global Dam Watch, FhRED, HydroRivers, FFR, and Protected Planet to create the dataframe (in the `connectivity` repository) in which we fed into this model. Details and links to each data set are below.

-   [Global Dam Watch (GDW)](https://www.globaldamwatch.org/):Database that has all existing hydropwer projects.

-   [Future Hydropower and Reservoir Data (FhRED)](https://www.globaldamwatch.org/directory):Data set with planned and future hydropower projects with capacity of at least 1 MW.

-   [Global River Networks (HydroRIVERS Dataset)](https://www.hydrosheds.org/products/hydrorivers): Provides vectorized spatial global river network data at 15 arc-second resolution, approximately 500 m at the equator, and includes river attributes.

-   [Free-Flowing Rivers database (FFR)](https://www.hydrosheds.org/applications/free-flowing-rivers):Using HydroSHED river network, creates a underpinning hydrographic data to support the identification of free-flowing and at-risk rivers.

-   [Protected Planet](https://www.protectedplanet.net/en):Database stores information on the global distribution of terrestrial and marine protected areas and OECMs, including those designated at national level and under regional and international conventions.

### File Structure

This repository contains code for the MCDA models including model testing, sensitivity testing, and data visualiztions. Each part is split into different folders and labeled by their action. In model creation, we experimented with Min-Max and Z-score normalization. Therefore, files are noted to which model the file corresponds to.

Descriptions of each folder and file can be viewed in the table below.

| File/Folder | **Description** |
|---------------------------|---------------------------------------------|
| R | MCDA Weight Sum Models using MinMax and Zscore normalization. |
| model_testing | Model testing of both functions over different data sets including fake and real data set subsets from the `connectivity` repository. |
| sensitivity_testing | Files for sensitivity testing for each model. The files labeled `sensitivity-testing-normzalitionStrategy` investigate how each dam score changes over various weights. The file labeled `sensitivity-testing-RANK-normzalitionStrategy` examines how dams are ranked differently over various weights. |
| figs | This contains any output figures. |
| data_viz | Data vizualization code. |

**File Path**

```{r}

```

### Packages and Software

To view packages used, versions, and software requirements, please view the "session_info.txt" file.

### Technical Documentation

To read more about the project and modeling processes, please refer to our [Bren project page](https://bren.ucsb.edu/projects/hydropowers-low-hanging-fruits-leveraging-least-impact-dams-power-net-zero-futurehttps://bren.ucsb.edu/projects/hydropowers-low-hanging-fruits-leveraging-least-impact-dams-power-net-zero-future) and technical documentation.
