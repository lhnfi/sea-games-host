#loading libraries
library(gcookbook)
library(ggplot2)
library(tidyr)
library(ggthemes)

#loading csv files
seagames <- read.csv("seagames.csv")

#changing somehow messed-up column name
names(seagames)[1] <- paste("Year")

#changing wide table into a long table using tidyr
seagames.long <- seagames %>% gather(Country,Gold,2:10)

#changing country column as factor
seagames.long$Country <- as.factor(seagames.long$Country)

#making xintercept table
vline.seagames <- data.frame(Country=levels(seagames.long$Country), host=c(1999,2011,2009,2001,2013,2005,2015,2007,2003))

#append an extra row for Malaysia
vline.seagames[nrow(vline.seagames)+1,] <- list("Malaysia",2017)

#making the plot
p <- ggplot(seagames.long,aes(x=Year,y=Gold)) + geom_path(color="#ff00f6") + geom_vline(data=vline.seagames, aes(xintercept=host), color="cyan", linetype="dashed") + facet_wrap( ~ Country) + ylim(0,185) + scale_x_discrete(limits=c(seagames$Year)) + labs(title="SEA Games gold medal tally by country", y="Gold Medal", caption="Data: Wikipedia\nData Viz: L. Hanafi") + theme_solarized_2(light=FALSE) + theme(text=element_text(size=32, family="Helvetica-Narrow"), plot.title=element_text(size=48, vjust=6), axis.text.x=element_text(size=18), panel.spacing = unit(2, "lines"), plot.margin=unit(c(1,1,1,1),"cm"))

#save the plot as pdf
ggsave ("SEA Games.pdf", plot=p, width=18, height=14)
