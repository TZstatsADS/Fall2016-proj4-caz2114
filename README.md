# Project: Words 4 Music

### [Project Description](doc/Project4_desc.md)

![image](http://cdn.newsapi.com.au/image/v1/f7131c018870330120dbe4b73bb7695c?width=650)

Term: Fall 2016

+ [Data link](https://courseworks2.columbia.edu/courses/11849/files/folder/Project_Files?preview=763391)-(**courseworks login required**)
+ [Data description](doc/readme.html)
+ Contributor's name:Catherine Zhao
+ Projec title: Music Match
+ Project summary: 
This project was a combination of features and words. In order to do this, I broke the project down into two components then later combining them. 

I started with using the words. By using topic modeling I created 20 different topics with words associated with this topic. This will be later used to help create the probabilty of each words. Then we moved to the features. We started with 15 different types of data such as bars confidence. For each song the length of the data was different. To normalize the data, I used smoothing to eastimate the data and adjust the length. I made the decision to include all components from the song. In order to do this, I used K-means to create 20 differernt different clusters for each component for all the songs. This means each song will have 15 labels based on features. 

The final step was to map the topic from the words to the 15 labels from k-means. By using neasest neighbor, we linked the probabilty of each type of words along with the proability of the word appearing.

To test the song, the program will take its 15 component and choose its label for each component. Following this, the program will take the probabilty the song is within a certain type of topic words and find the probabilties. Then the program will rank the words. 
	
Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
