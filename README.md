# LegitiFact Source Checker Bot
Visit the bot in action at https://www.facebook.com/legitifact/

# Usage
    perl ./run-source-checker [time]

The script pulls all link shares made by major Facebook news outlet pages, and reshares them while providing evaluations on their credibility, bias, and accuracy, backed by research from established polling and fact-checking institutions. The app takes an argument, $ARGV[0], the number of minutes of recent posts to query from each page.

# Inspiration

In the context of the current media landscape, media literacy has become an invaluable necessity. The goal of this project is to educate social media users by evaluating news articles shared by widely viewed Facebook pages for accuracy, trustworthiness, and bias. We hope to promote greater media literacy among Facebook users in order to improve the spread of verifiable, trusted sources, and encourage readers to consume sources that present diverse viewpoints.

# Function

Our Facebook page does two things. 
#### Content Aggregator
First of all, it is a content aggregator. It continuously queries major news/media pages on Facebook, and reposts them onto its own page. It queries recent posts in near-real-time, from more than 50 major Facebook news media pages. This allows a diversity of media opinion to be presented equally alongside its peers.

#### Source Evaluations
Second, our bot presents a succinct but informative evaluation of each source linked from a major Facebook page. This evaluation informs the reader about the credibility of the source as seen by a diverse sample of respondents surveyed by the Pew Research Center. Additionally, it uses information from the study to acknowledge the existence of partisan differences in the perceived of each source. Lastly, it links readers to the Pew Research Center's 2014 research study on Political Polarization & Media Habits from which we obtained this information.

# Build Details
This script is written in perl, taking advantage of the Facebook::Graph API to interface with Facebook Pages. The API is used to query and retrieve public posts made by major public Facebook pages. Recently created posts that contain links are extracted and compared with our existing database of news source evaluations from the Pew Research Center. These posts are then shared as new posts on the Legitifact public page, along with a brief summary evaluation of the source. By sharing the same post as the original source, we take advantage of Facebook's News Feed algorithm to guarantee that our post containing the evaluation is consolidated together with the original, so that users will be able to view our automated post at the same time as the original.

##Authors

Timmy Huang 
github.com/th174
th174@duke.edu

Delia Li
github.com/delia-li
dl202@duke.edu
