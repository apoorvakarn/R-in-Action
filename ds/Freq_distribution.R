Attendance <- c('A','A','P','P','A','P','A')
Attendance <- data.frame(Attendance)
Attendance

colour <- c('Red','Blue','Green','Magenta','Green','Black','Blue','Black')
colour <- data.frame(colour)
colour

Siblings <- c(2,1,2,4,1,0,1,2,4,2)
Siblings<- data.frame(Siblings)
Siblings

freqAttn <-data.frame(table(Attendance))
freqAttn

FreqColor <-data.frame(table(colour))
FreqColor

freqsibling <-data.frame(table(Siblings))
freqsibling


