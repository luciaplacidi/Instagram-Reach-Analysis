data <- read.csv("~/Projects/Instagram_data.csv")
head(data)
options(digits = 3, scipen = 99999)
set.seed(12345)

#checking for NAs
colSums(is.na(data))

#checking types
str(data)

# distribution of impressions reached from home (followers)
dist_home <- hist(data$From.Home,
                  col="lightseagreen",
                  main = "Distribution of Impressions from Home",
                  xlab="From Home")

#distribution of impressions from hashtags
dist_hash <- hist(data$From.Hashtags,
                  col="lightseagreen",
                  main = "Distribution of Impressions from Hashtags",
                  xlab="From Hashtags")

#distribution from explore page
dist_explore <- hist(data$From.Explore,
                     col="lightseagreen",
                     main = "Distribution of Impressions from Home",
                     xlab="From Explore Page")

#percentage of impressions from different sources - pie chart
home <- sum(data$From.Home)
hashtags <- sum(data$From.Hashtags)
explore <- sum(data$From.Explore)
other <-sum(data$From.Other)

pie_imp <- data.frame(
  lab=labels,
  val=values
)

labels <- c('From Home','From Hashtags','From Explore','Other')
values <- c(home, hashtags, explore, other)


bp <- ggplot(pie_imp, aes(x="", y=values, fill=labels))+
  geom_bar(width=1, stat="identity")
bp

pie <- bp + coord_polar("y", start=0)
pie

pievalues <- paste0(round(100 * values/sum(values), 2), "%")
pie(values, labels = pievalues,
    col = c("palevioletred1", "plum", "indianred1", "lightsalmon"),
    main="Impressions by Source")
legend("topright", legend=labels, fill=c("palevioletred1", "plum", "indianred1", "lightsalmon"))


# Analyzing Relationships

# like vs impressions
like_imp_scatter <- plot(data$Impressions, data$Likes,
                         main = "Likes vs Impressions",
                         xlab="Impressions", ylab="Likes",
                         col="lightseagreen",)
abline(lm(data$Likes ~ data$Impressions), col="indianred1")


# comments vs impressions
comm_imp_scatter <- plot(data$Impressions, data$Comments,
                         main = "Comments vs Impressions",
                         xlab="Impressions", ylab="Comments",
                         col="lightseagreen",)
abline(lm(data$Comments ~ data$Impressions), col="indianred1")

# shares vs impressions
shares_imp_scatter <- plot(data$Impressions, data$Shares,
                         main = "Shares vs Impressions",
                         xlab="Impressions", ylab="Shares",
                         col="lightseagreen",)
abline(lm(data$Shares ~ data$Impressions), col="indianred1")


# saves vs impressions
save_imp_scatter <- plot(data$Impressions, data$Saves,
                         main = "Saves vs Impressions",
                         xlab="Impressions", ylab="Saves",
                         col="lightseagreen")
abline(lm(data$Saves ~ data$Impressions), col="indianred1")


# Analyzing Conversion Rate
# conversion rate = how many followers from the number of profile visits from a post.
# = (follows/profile visits) * 100
conversion_rate <- (sum(data$Follows) / sum(data$Profile.Visits)) *100
conversion_rate

# follows vs profile visits
follows_visits_scatter <- plot(data$Profile.Visits, data$Follows,
                         main = "Follows vs Profile Visits",
                         xlab="Profile Visits", ylab="Follows",
                         col="lightseagreen")
abline(lm(data$Follows ~ data$Profile.Visits), col="indianred1")


# Finding what the most important factors are for Impressions.
# Variable importance

(V = varImp(model))
plot(V)

# Plot variable importance scores
vip::vip(model, method = "firm", ice = TRUE)            

ggplot2::ggplot(V, aes(x=reorder(rownames(V),Overall), y=Overall)) +
  geom_point( color="red", size=4, alpha=0.6)+
  geom_segment( aes(x=rownames(V), xend=rownames(V), y=0, yend=Overall), 
                color='darkred') +
  xlab('Variable')+
  ylab('Overall Importance')+
  theme_classic() +
  coord_flip()


# Predict Reach
datamodel <- data[-c(2,3,4,5,12,13)]
library(caret)

# Split data into training and testing data
index <- createDataPartition(datamodel$Impressions, p = 0.8, list = FALSE)
training_data <- datamodel[index, ]
testing_data <- datamodel[-index, ]

# Fit a linear regression model and predict the reach of the testing data
model <- lm(Impressions ~ ., data = training_data)
predicted_reach <- predict(model, newdata = testing_data)

# Evaluate the performance of the model
rmse <- sqrt(mean((testing_data$Impressions - predicted_reach)^2))
print(paste0("Root Mean Squared Error (RMSE): ", rmse))

plot(testing_data$Impressions, predicted_reach,
     xlab = "Actual Reach", ylab = "Predicted Reach",
     main = "Predicted vs Actual Reach",
     col="lightseagreen")

# Add reference line
abline(0, 1, col = "indianred1")

