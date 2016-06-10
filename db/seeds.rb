contents = [
  %(
    <p>A child asked his father, "How were people born?"</p>
    <p>So his father said, "Adam and Eve made babies, then their babies became adults and made babies, and so on."</p>
    <p>The child then went to his mother, asked her the same question and she told him, "We were monkeys then we evolved to become like we are now."</p>
    <p>The child ran back to his father and said, "You lied to me!"</p>
    <p>His father replied, "No, your mom was talking about her side of the family."</p>
  ),
  %(
    <p>Teacher: "Kids,what does the chicken give you?"</p>
    <p>Student: "Meat!"</p>
    <p>Teacher: "Very good! Now what does the pig give you?"</p>
    <p>Student: "Bacon!"</p>
    <p>Teacher: "Great! And what does the fat cow give you?"</p>
    <p>Student: "Homework!"</p>
  ),
  %(
    <p>The teacher asked Jimmy, "Why is your cat at school today Jimmy?"</p>
    <p>Jimmy replied crying, "Because I heard my daddy tell my mommy, 'I am going to eat that pussy once Jimmy leaves for school today!'"</p>
  ),
  %(
    <p>A housewife, an accountant and a lawyer were asked "How much is 2+2?"</p>
    <p>The housewife replies: "Four!".</p>
    <p>The accountant says: "I think it's either 3 or 4. Let me run those figures through my spreadsheet one more time."</p>
    <p>The lawyer pulls the drapes, dims the lights and asks in a hushed voice, "How much do you want it to be?"</p>
  )
]

Joke.delete_all

contents.each do |c|
  Joke.create(content: c)
end
