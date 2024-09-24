---
layout: blog
title: 2024-05-08 Flickr Images Pixel Color Classification
category: [Project, Computational Graphics, ML Project]
excerpt: Project
---

Recently I did a simple project that leverage social media's image and image title/tags for training an image color classification model.


# Project: An Innovative Approach to Color Classification with Social Media Images

## Project Summary
Welcome to our exploration of pixel-wise RGB to color name classification. Our project delves into the nuanced domain of color perception and its application in image analysis, using machine learning to bridge the gap between raw color data and human-understandable labels.

## Motivation and Impact
Colors convey deep meanings and emotions, significantly impacting how we perceive visuals. This project introduces an automatic, unsupervised method to classify colors in images, aiding tasks like mood analysis and object detection. By leveraging unsupervised learning, we bypass the need for manually labeled data, using social media imagery as a training set. Our approach demonstrates how to efficiently use publicly sourced data to build a robust color classifier, potentially revolutionizing how we handle image data compression and feature extraction.

## Data Collection and Processing
Our data is sourced from Flickr, utilizing user-generated tags to collect images corresponding to specific color names. We face challenges like image noisiness—where irrelevant colors dominate the intended label. To combat this, we've developed innovative denoising techniques that refine our training dataset, ensuring that our model learns from the most relevant features.
![alt text](/images/blog/2024-05/DataCollection.png)



## Technical Approach
The core of our model is a shallow machine learning algorithm that takes a simple 1x3 RGB vector and predicts a color category. We utilize multiple classifiers from the scikit-learn library, such as Logistic Regression and Random Forest, to ensure robustness and accuracy in our predictions.

### Innovations:
- **Unsupervised Learning**: Utilizing weak labels from social media for training.
- **Robust Classification**: Addressing the challenge of noisy, real-world data.
- **Data Efficiency**: Demonstrating a potential 1/24 compression ratio by simplifying color data.

## Model Training and Evaluation
We train our model using a capped number of data points per class to maintain balance and performance. The effectiveness of our model is measured both visually and quantitatively, with a custom 'golden dataset' for rigorous testing. Our evaluation showcases the model's capability to accurately classify and represent colors, compressing the original image data significantly.

## Results
The results are promising, with most pixels accurately classified into one of eight categories. This success is illustrated through side-by-side comparisons of original and classified images, providing a clear visual representation of the model's performance.

![alt text](/images/blog/2024-05/ClassificationResult.png)

![alt text](/images/blog/2024-05/Performance.png)

## Setup Instructions
To replicate our environment or use our model:
1. Install dependencies via Poetry.
2. Download images either through our provided script or directly via a shared drive link.
3. Follow our step-by-step scripts for image cleaning, model training, and evaluation.

## Looking Forward
This project not only advances the field of image processing but also opens up new avenues for using machine learning in real-world applications. Future enhancements can include expanding the number of color categories and refining the



