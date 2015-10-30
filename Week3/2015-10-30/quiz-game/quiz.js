var read = require('read');

var Question = function(qid, question, answer) {
    this.qid = qid;
    this.question = question;
    this.answer = answer;
    this.score = 0;
}


var Quiz = function(questions) {
    this.questions = questions;
    this.currentQuestion = null;
}

Quiz.prototype.getCurrentQuestion = function() {
    this.currentQuestion = this.questions[0]
};

Quiz.prototype.displayQuestion = function(err, input) {
    if (this.questions.length === 0) {
        console.log("Quiz finished");
        return;
    } else {
        console.log(this.currentQuestion.question);
        this.processAnswer(input);
    }

};

Quiz.prototype.userInput = function() {
    this.getCurrentQuestion();
    console.log(this.currentQuestion.question);

    options = {
        prompt: "> "
    }

    read(options, this.displayQuestion.bind(this));
};

Quiz.prototype.processAnswer = function(input) {
    // LOGIC
    if (input === this.currentQuestion.answer) {
        console.log("good one");
        this.questions.shift();
        this.getCurrentQuestion();
        //if (this.currentQuestion != undefined) {
            //console.log(this.currentQuestion.question);
        //}
        read(options, this.displayQuestion.bind(this));
    } else {
        console.log("bad one");
        read(options, this.displayQuestion.bind(this));
    }
}


var questions = [new Question(1, "1+1", "2"), new Question(2, "2+1", "3"),
                new Question(3, "5+3", "8")
                ]
var quiz = new Quiz(questions);
quiz.userInput();
