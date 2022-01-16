import csv

#open csv file with all reviews 
with open('userReviews all three parts.csv', 'r', encoding="utf8") as reviews:
    reader = csv.DictReader(reviews, delimiter=';')
    data = list(reader)
    
    
#define a list with all scores to favorite movie "spring-breakers"
X = []

for row in data:
    if row['\ufeffmovieName'] == 'spring-breakers' :
        X.append(row['Metascore_w'])

        
#transform to integer
x = list(map(int, X))
#print(x)

#compute the average of the user score for the movie "spring breakers" over all reviews 
def Average(x) :
    return sum(x) / len(x)

m = Average(x)

print('m = ' , m)



#My rating for this movie would be a 9! 
#most reviwers think in a ddifferent way - but the movie is specifically for a smaller audience (yound woman arund the age of 20-25) and contains strong language as well.
#Therefore, I can understand the lower rating, even if my personal opinion differs.


#create a list with all Authors who rated movie "spring breakers"
Y = []
for row in data:
    if row['\ufeffmovieName'] == 'spring-breakers' : #\ufeffmovieName is the name of the first column (\ufeff appeard before the actual name)
        Y.append(row['Author'])

Yset = set(Y) #to get unique values
Ylst = list(Yset) #transform back into a list
#print(Ylst)

#create a list with all movies which were reviewed by the selected Authors (including duplicats)
Z=[]
for row in data:
    if row['Author'] in Ylst:
        Z.append(row['\ufeffmovieName'])

#print(Zlst)

#define a list with all user scores from movies in list 
W = []
for row in data:
    if row['\ufeffmovieName'] in Z:
        W.append(row['Metascore_w'])
Wlst = list(map(int, W))
#print(W)


#combine moviename and UserScore in a nested list
Nlst = [list(l) for l in zip(Z, Wlst)]
#print(Nlst)

#create the final list - define the movies with a similar or higher score than m
final = []
for name, score in Nlst:
    if score >= m:
        final.append(name)

finalset = set(final) #to get unique values
finallst = list(finalset) #transform back into a list

#write the recommended movies into a csv file
RESULTS =[finallst]
with open('recommendations_based_on_spring_breakers_ResitTask.csv', 'w') as file:
     writer = csv.writer(file, quoting=csv.QUOTE_ALL)
     writer.writerows(RESULTS)