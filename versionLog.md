OK, I think I got the basic structure now.

Being honest, I'm a little afraid because of how many transitive tables I have...

###Stories
Alright, my first independent table is **stories** which each make up for a book.

I want to keep a record of books, editions, translations and such on my databse, so I created a **bookEditions** table to record it.

This one connects with many more tables because I am thinking of creating a sort of library for each book on the final website. Like a log of characters, events, and locations involved in each book that people can explore for references while reading (hopefully with some images too).

###Characters

Second I'll talk about **characters**. I created something basic to record characters, though I connected it to hometowns and lands... (I really wanted to keep this one independent T-T)

Also character profiles are a little different for each story (since time goes by and people grow up), so I connected it with **stories** and created the **characterProfiles** table. This way a characters will have a profile for each book.

Also, I connected **characterProfiles** to the **organizations** they belong to in on each book, but kept the original **characters** table related to the **events** they take part in.

(I wonder if I should relate **events** and **characterProfiles** instead...)

###Events

Each story is made up by **events**, and one event can span over many **stories**, so the relationship felt somewhat obvious.

Also, events happen in a **location**, which in turn connects it to a **land**. And many **characters** and **organizations** take part too.

###Lands

**lands** help me identify locations and establish an overall feel to them. Much like riot does with all of runaterra's locations for the League of Legends franchise.

Also, creating **locations** articles will let me help readers grab a feel of the place where **events** take place.

(I wonder if I'll be able to connect **events** and **lands** easily on a query, or if I'll have to make a direct connection between them...)

###Organizations
Last but not least, **organizations** let me group **characters** with common interests. (Though I wonder if the connection should be with **characterProfiles** instead...)

And, of course, **organizations** come from a **land** and take part in **events**, and **stories**

###Next steps
Now that the basic structure is done, it is time for the DDL Script!




