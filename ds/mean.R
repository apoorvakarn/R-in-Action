x = scan()
x
mean(x)
y = scan(what = 'character')
y
median(x)
ux <- unique(x)
ux[which.max(tabulate(match(x, ux)))]
ux
getmode(x)
sort(x)
sort(table(x),decreasing = TRUE)
