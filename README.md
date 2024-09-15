# Do influential Yelp users give higher ratings to take-out restaurants compared to non-influential users, and how do factors like location and business features affect these ratings?

![image](https://miro.medium.com/v2/resize:fit:1012/1*6mGFJh8XrCqOlBRRvf2Deg.png)

## Introduction
Since its launch in 2004, Yelp, as one of the largest online review platforms, has played a crucial role in shaping the reputations of businesses, particularly in the food industry. While there is an abundance of research analyzing Yelp reviews (*Agarwal, Pelullo, & Merchant 2019; Arthur, Etzioni, & Schwartz, 2019*), most studies focus on general patterns of consumer behavior (*Fogel, J. and Zachariah, S., 2017*), sentiment analysis (*Guerreiro & Rita, 2020*), or the detection of fake reviews (*Lee, Ham, Yang, & Koo, 2018*). What these studies largely overlook, however, is the significant role that influential users—those with elite status, numerous followers, or high review counts—play in shaping business ratings (*Pranata, I. and Susilo, W., 2016*). These users wield disproportionate influence on the platform, and their ratings are often perceived as more credible and trustworthy than those of regular users (*Tucker, T., 2011*).

### Research Motivation
In competitive sectors like the food industry, where reputation can make or break a business, understanding the impact of these influential users is essential, as evidenced in a study conducted by  *Nakayama and Wan (2018)* about one-third of customers rely on online reviews when choosing a restaurant and over half of 18-to-34-year-olds factor reviews into their dining decisions. Moreover, while the food industry on Yelp has been extensively studied (*Anderson and Magruder, 2012*) because of its tremendous impacts on business outcomes (*Luca, 2016*), the take-out restaurant niche has received minimal attention. The majority of existing studies on take-out restaurants emphasize negative aspects such as health risks, obesity, and food safety concerns (*Jeffery et al., 2006; Baek et al., 2022*). These studies tend to focus on the health implications of frequent take-out consumption but fail to address the consumer dynamics on platforms like Yelp, where reviews have the power to influence public perception and business success _(Jiménez, et al. 2013)_. This gap in the literature calls for a deeper investigation into how influential users interact with take-out restaurants, especially as take-out has become increasingly important in the post-pandemic dining landscape.

Additionally, the accessibility and usefulness of the output from this study significantly benefit other students and the larger scientific community. By **developing an automated and reproducible workflow using open-source tools like R**, this research provides a template that others can easily adapt for similar analyses. **The study's findings and the associated code** can be shared on public platforms like GitHub, making them readily available for educational purposes and further research. The workflow includes data extraction, cleaning, transformation, and modeling processes, all documented and scripted to ensure transparency and repeatability. Moreover, the **comprehensive PDF report** serves as a valuable resource that clearly communicates the research methods, analyses, and findings. It can be used as a teaching tool in academic settings, demonstrating how to approach complex data analyses and interpret results within a real-world context.

### Research Question
This study aims to address this gap in the dynamics of online reviews, especially from influential Yelp users, by asking: **Do influential Yelp users give higher ratings to take-out restaurants compared to non-influential users, and how do factors like location and business features affect these ratings?** This research is critical for several reasons. First, understanding the behavior of influential users could help businesses better manage their online reputations, particularly in a niche market like take-out dining. Second, the relationship between user influence, business attributes (such as parking availability or hours of operation), and location can provide key insights into consumer decision-making. For businesses operating in highly competitive environments, especially those without an established offline presence, this research could offer practical strategies for improving ratings and attracting new customers.

### Variable types

| Variable      | Description                                                         | Data class | Dataset           |
|---------------|:-------------------------------------------------------------------:|-----------:|-------------------|
| business_id   | A unique character string for each individual business              | numeric    | business dataset  |
| name          | The business name                                                   | character  | business dataset  |
| city          | The city name where the business is located                         | character  | business dataset  |
| state         | The state name where the business is located                        | character  | business dataset  |                                   
| stars         | The average star rating rounded to half-stars                       | numeric    | business dataset  |
| review_count  | The number of reviews                                               | numeric    | business dataset  |
| is_open       | Variable that shows with 0 or 1 of the business is closed or open   | numeric    | business dataset  |
| attributes    | Business attributes to values                                       | character  | business dataset  |
| user_id       | An unique character string as user id                               | numeric    | user dataset      |
| review_count  | The number of reviews                                               | numeric    | user dataset      |
| yelping_since | Date when user joined Yelp                                          | numeric    | user dataset      |
| fans          | The number of fans the user has                                     | numeric    | user dataset      |
| elite         | The years the user was 'elite'                                      | numeric    | user dataset      |
| user_id       | An unique character string as user id                               | numeric    | review dataset    |
| business_id   | A unique character string for each individual business              | numeric    | review dataset    |
| review_id     | Unique review id                                                    | numeric    | review dataset    |
| stars         | The average star rating rounded to half-stars                       | numeric    | review dataset    |

### Conceptual model
## Research Method and Results 
### Data Source
From the Yelp database the business, user, and review data files are downloaded to answer the research question. 
- Yelp Database (https://www.yelp.com/dataset/download)

Since the file is in .tar format, we need to extract it into separate JSON files by using R. The next step is to convert the JSON files into CSV format using Python code.  You can find the R & Python code here:
- Extracting JSON files: https://github.com/course-dprep/team-project-no-vs-code-team-12-1/blob/main/tar_format_to_json_converter.R
- Converting CSV files: https://github.com/course-dprep/team-project-no-vs-code-team-12-1/blob/main/json_to_csv_converter.py

Finally, run the script from your terminal with the following command and replace *yelp_academic_dataset.json* with the path to the JSON file you wish to convert. The script will generate a CSV file with the same name as your input JSON file, located in the same directory.

```{r}
python json_to_csv_converter.py yelp_academic_dataset.json
```

### Research Method
To explore these relationships, **regression analysis** will be employed as the primary research method. This method is well-suited for controlling multiple factors such as restaurant location, business attributes (e.g., parking, takeout options), and user metrics (e.g., yelping_since, fans, elite status). By using regression, we can isolate the effect of user influence on ratings and better understand the causal relationships at play. The analysis will focus on key variables like user profiles (including elite status, review count, and average stars), and business characteristics from the Yelp dataset. This approach will help to provide a clearer picture of how influential users impact the ratings of take-out restaurants compared to non-influential users.

### Result  


## Relevance of analysis / Future applications


## Repository Overview


## Dependencies


## Running instructions


## Authors
This repository was created for the Data Preparation and Workflow Management course, taught by Hannes Datta at the Tilburg School of Economics and Management, as part of the Master's program in Marketing Analytics. It is a collaboration by Team 12, consisting of:
- Kris Bruurs
- Ly Ba Tho
- Jelle de Bie
- Zeynep Yavlal
- Bart van de Mortel

## Research Reference
- Agarwal, A.K., Pelullo, A.P. and Merchant, R.M., 2019. “Told”: the word most correlated to negative online hospital reviews. Journal of General Internal Medicine, 34, pp.1079-1080.
- Anderson, M. and Magruder, J., 2012. Learning from the crowd: Regression discontinuity estimates of the effects of an online review database. The Economic Journal, 122(563), pp.957-989.
- Arthur, J.R., Etzioni, D. and Schwartz, A.J., 2019. Characterizing extremely negative reviews of total joint arthroplasty practices and surgeons on yelp. com. Arthroplasty Today, 5(2), pp.216-220.
- Baek, S., Suk, Y., Lee, H. and Ham, S., 2022. The influence of customer perception about food safety on the use of restaurant food delivery or takeout. Journal of the Korean Dietetic Association, 28(3), pp.182-194.
- Fogel, J. and Zachariah, S., 2017. Intentions to use the yelp review website and purchase behavior after reading reviews. Journal of theoretical and applied electronic commerce research, 12(1), pp.53-67.
- Guerreiro, J. and Rita, P., 2020. How to predict explicit recommendations in online reviews using text mining and sentiment analysis. Journal of Hospitality and Tourism Management, 43, pp.269-272.
- Jeffery, R.W., Baxter, J., McGuire, M. and Linde, J., 2006. Are fast food restaurants an environmental risk factor for obesity?. International Journal of Behavioral Nutrition and Physical Activity, 3, pp.1-6.
- Jiménez, F.R. and Mendoza, N.A., 2013. Too popular to ignore: The influence of online reviews on purchase intentions of search and experience products. Journal of interactive marketing, 27(3), pp.226-235.
- Lee, K., Ham, J., Yang, S.B. and Koo, C., 2018. Can you identify fake or authentic reviews? An fsQCA approach. In Information and Communication Technologies in Tourism 2018: Proceedings of the International Conference in Jönköping, Sweden, January 24-26, 2018 (pp. 214-227). Springer International Publishing.
- Luca, M., 2016. Reviews, reputation, and revenue: The case of Yelp. com. Com (March 15, 2016). Harvard Business School NOM Unit Working Paper, (12-016).
- Nakayama, M. and Wan, Y., 2019. The cultural impact on social commerce: A sentiment analysis on Yelp ethnic restaurant reviews. Information & Management, 56(2), pp.271-279.
- Pranata, I. and Susilo, W., 2016. Are the most popular users always trustworthy? The case of Yelp. Electronic Commerce Research and Applications, 20, pp.30-41.
- Tucker, T., 2011. Online word of mouth: characteristics of Yelp. com reviews. Elon Journal of Undergraduate Research in Communications, 2(1), pp.37-42.
