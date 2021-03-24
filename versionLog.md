##210307 - Diagram first steps
domingo, 7 de marzo de 2021
9:53 a. m.

I made a draft of the entity relationship diagram to challenge myself after having the class. Though I didn't know about data types, constraints or relationships then, so I'll have to update it on the go.

I chose the app of diagrams.net to start working on it.

###Characters table
I decided to begin with the characters table. I thought about adding more columns, but figured that many of the attributes could change from book to book. So I only stuck with things that would prevail all along the series.

I'll look into it again after advancing a little more.

###Stories table
This one is about the stories that make up for a whole book.

A few attributes could change according to the eddition (like language, publication date, and so on). So I decided to stick with the basics as I go on.

*I put an author field. I might drop it later. But I figured that I might allow other writer's work into the series.

If that's the case, then I should think about an author table… Perhaps I'll make it for universal use…

###BookEditions table
Ok, a book can have many editions, and can be published in many languages by different publishers… 

A single story can have many books, but a book only corresponds to a single story…

I'll cover what I know right now. And I'll complement it as publish

###Final status
… I truly wonder how publishers store their data.



