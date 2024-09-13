# Do influential Yelp users give higher ratings to take-out restaurants compared to non-influential users, and how do factors like location and business features affect these ratings?


## Introduction
### Research Motivation
Since its launch in 2004, Yelp, as one of the largest online review platforms, has played a crucial role in shaping the reputations of businesses, particularly in the food industry. While there is an abundance of research analyzing Yelp reviews (*Agarwal, Pelullo, & Merchant 2019; Arthur, Etzioni, & Schwartz, 2019*), most studies focus on general patterns of consumer behavior (*Fogel, J. and Zachariah, S., 2017*), sentiment analysis (*Guerreiro & Rita, 2020*), or the detection of fake reviews (*Lee, Ham, Yang, & Koo, 2018*). What these studies largely overlook, however, is the significant role that influential users—those with elite status, numerous followers, or high review counts—play in shaping business ratings (*Pranata, I. and Susilo, W., 2016*). These users wield disproportionate influence on the platform, and their ratings are often perceived as more credible and trustworthy than those of regular users (*Tucker, T., 2011*). In competitive sectors like the food industry, where reputation can make or break a business, understanding the impact of these influential users is essential, as evidenced in a study conducted by  *Nakayama and Wan (2018)* about one-third of customers rely on online reviews when choosing a restaurant and over half of 18-to-34-year-olds factor reviews into their dining decisions.

Moreover, while the food industry on Yelp has been extensively studied (*Anderson and Magruder, 2012*) because of its tremendous impacts on business outcomes (*Luca, 2011*), the take-out restaurant niche has received minimal attention. The majority of existing studies on take-out restaurants emphasize negative aspects such as health risks, obesity, and food safety concerns (*Jeffery et al., 2006; Baek et al., 2022*). These studies tend to focus on the health implications of frequent take-out consumption but fail to address the consumer dynamics on platforms like Yelp, where reviews have the power to influence public perception and business success. This gap in the literature calls for a deeper investigation into how influential users interact with take-out restaurants, especially as take-out has become increasingly important in the post-pandemic dining landscape.

This study aims to address this gap by asking: **Do influential Yelp users give higher ratings to take-out restaurants compared to non-influential users, and how do factors like location and business features affect these ratings?** This research is critical for several reasons. First, understanding the behavior of influential users could help businesses better manage their online reputations, particularly in a niche market like take-out dining. Second, the relationship between user influence, business attributes (such as parking availability or hours of operation), and location can provide key insights into consumer decision-making. For businesses operating in highly competitive environments, especially those without an established offline presence, this research could offer practical strategies for improving ratings and attracting new customers.

To explore these relationships, **regression analysis** will be employed as the primary research method. This method is well-suited for controlling multiple factors such as restaurant location, business attributes (e.g., parking, takeout options), and user metrics (e.g., yelping_since, fans, elite status). By using regression, we can isolate the effect of user influence on ratings and better understand the causal relationships at play. The analysis will focus on key variables like user profiles (including elite status, review count, and average stars), and business characteristics from the Yelp dataset. This approach will help to provide a clearer picture of how influential users impact the ratings of take-out restaurants compared to non-influential users.

Additionally, the accessibility and usefulness of the output from this study significantly benefit other students and the larger scientific community. By **developing an automated and reproducible workflow using open-source tools like R**, this research provides a template that others can easily adapt for similar analyses. **The study's findings and the associated code** can be shared on public platforms like GitHub, making them readily available for educational purposes and further research. The workflow includes data extraction, cleaning, transformation, and modeling processes, all documented and scripted to ensure transparency and repeatability. Moreover, the **comprehensive PDF report** serves as a valuable resource that clearly communicates the research methods, analyses, and findings. It can be used as a teaching tool in academic settings, demonstrating how to approach complex data analyses and interpret results within a real-world context.

### Research Question
Do influential Yelp users give higher ratings to take-out restaurants compared to non-influential users, and how do factors like location and business features affect these ratings?

### Variable types

| Variable      | Description                                             | Data class | Dataset           |
|---------------|:-------------------------------:                        |-----------:|-------------------|
| business_id   | A unique character string for each individual business  | numeric    | business dataset  |
| name          | City of observation                                     | character  | business dataset  |
| city          | Date of booking                                         | Date       | business dataset  |
| state         | Type of room                                            | character  | business dataset  |                                   
| stars         | Neighbourhood of city                                   | character  | business dataset  |
| review_count  | Rating of the room                                      | numeric    | business dataset  |
| is_open       | Rating of the room                                      | numeric    | business dataset  |
| attributes    | Rating of the room                                      | numeric    | business dataset  |
| review_count  | Rating of the room                                      | numeric    | business dataset  |


### Conceptual model


## Research Method and Results 
### Data Source
### Research Method
### Result  


## Relevance of analysis / Future applications


## Repository Overview


## Dependencies


## Running instructions


## Authors
