# Instagram Reach Analysis using R

## Objective
* Analyze the data to find relationships between Instagram impressions and Likes, Comments, Shares and Saves.
* Find the conversion rate per post.
* Create a linear regression model to predict the reach (impressions) per post.

## Visualizations & Findings

### Analyzing Reach
<img width="936" alt="Analyzing Reach" src="https://user-images.githubusercontent.com/119815423/218291601-8ecdfde4-7234-4e90-8e87-09ed072d7150.png">

<img width="268" alt="Pie Chart" src="https://user-images.githubusercontent.com/119815423/218291617-b581fa95-9779-4be2-bfa4-f44bc13421a3.png">

* The pie chart above shows that most Impressions are gained from followers at 44.11%, followed by Hashtags at 33.63%, 19.21% from the Explore page,
and impressions from other sources contribute to 3.05%.

### Analyzing Relationships
<img width="936" alt="Analyzing Relationships" src="https://user-images.githubusercontent.com/119815423/218291619-163b5014-4f99-43e1-bf64-1eb177646e3c.png">

* Analyzing factors to find the most important factors for reach. It will help us understand how the algorithm works.
* There is a positive linear correlation between likes and impressions, where likes increase as impressions also increase.
* The neutral correlation between comments and impressions shows that the number of comments doesn't impact the post's reach.
* The higher number of shares will result in a higher reach, but it doesn't impact the reach as much as likes do.
* The number of saves per post will impact reach more than shares but less than likes.

### Analyzing Conversion Rate

* Conversion Rate = (follows / profile visits) * 100
* The conversion rate for this Instagram account is 41%. This is above average as the typical rate is between 2-5%.

<img width="331" alt="Analyzing Conversion Rate" src="https://user-images.githubusercontent.com/119815423/218291627-b5603278-8cbd-4243-aa3d-d2fdffa235ff.png">

* The relationship between follows and profile visits is linear, with both increasing simultaneously.

### Variable Importance
BAR CHART

* The bar chart shows the overall imortance each variable has on the reach a post gets.
* It confirms the results from the scatterplots, where follows, likes and saves impact reach more than shares and comments.

### Instagram Reach Prediction Model

<img width="320" alt="Instagram Reach Prediction Model" src="https://user-images.githubusercontent.com/119815423/218291630-b2336767-43d2-41c4-b1f2-59287dbdcca6.png">

* I created a prediction model by first splitting the data into testing and training sets. Then, I fit a linear regression model and predicted the reach and plot it on a graph with actual and predicted reach.
