---
title       : Reproducible Pitch
subtitle    : Least Squares User Tool
author      : Erhard Menker
job         : Data Science Specialization - Developing Data Products
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
github:
    user: erhardmenker
    repo: Developing_Data_Products_Proj
---

## Introduction ##

- Linear regression is the fundamental tool of inferential data science, but its results are often not questioned in an intuitive way
- Expectations aren't often enough assessed before estimation, a point when the data scientist has a less biased mind
- My Shiny app allows users to think about linear regression in an intuitive way by testing their perceived best linear fit of a dataset against that produced by least squares
- This Shiny app can be accessed at: https://erhardmenker.shinyapps.io/courseProject/

---

## Concept (1) ##

- For simplicity, my Shiny app sources the built in mtcars dataset and plots the car's weight on the y-axis and corresponding MPG on the x-axis

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-1.png)

---

## Concept (2) ##

- While the best linear line is defined as the one that minimizes the sum of squared errors (pictured below), this app gives the user the ability to look at the data and intuit what the best line could be expected to be (before estimation) and then compared (after estimation)

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png)

---

## Purpose ##

- My Shiny app allows users to fit their own linear regression based on their examination of the data and compare their answer to the result obtained by the least squares criterion
- This comparison allows users to compare their expectations to the standard least squares output; this illuminates potential issues, like outliers or the need for polynomial terms, that could be mitigated with more advanced tools
- Users also have the ability to add random normals to the data and see how much this impacts the fit; this is a non-technical way to assess how susceptible the model's fit is to random deviations
