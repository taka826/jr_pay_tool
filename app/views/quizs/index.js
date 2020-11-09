//問題文を定義
const quiz = [
  {
    question: '回数券の精算方法はどれ？',
    answers: ['差額精算' ,'打ち切り精算', '区間変更'],
    correct: '打ち切り精算'
  }, {
    question: '定期券利用時に乗り越し精算を求めてきた、正しい精算方法はどれ？',
    answers: [ '差額精算', '打ち切り精算', '区間変更'],
    correct: '打ち切り精算'
  }, {
    question: '2日有効の切符で精算を求めてきた、発駅は正しい場合の精算方法はどれ？',
    answers: [ '差額精算', '打ち切り精算', '区間変更'],
    correct: '差額精算'
  }, {
    question: '3日有効の切符で大宮幹下東京行きの切符を出してきた、正しい精算方法はどれ？',
    answers: [ '差額精算', '打ち切り精算', '区間変更'],
    correct: '区間変更'
  }, {
    question: '大宮幹下東京行きの切符区間変更、正しい分岐駅はどれ？',
    answers: [ '大宮', '武蔵浦和', '東京'],
    correct: '武蔵浦和'
  }, {
    question: '1日有効のエド券の精算方法として正しいのはどれ？',
    answers: [ '差額精算', '打ち切り精算', '区間変更'],
    correct: '差額精算'
  }, {
    question: 'では、1日有効の大型券の精算方法として正しいのはどれ？',
    answers: [ '差額精算', '打ち切り精算', '区間変更'],
    correct: '差額精算'
  }, {
    question: '3日有効の切符で大宮幹下東京行きの企画券の場合、精算方法として正しいのはどれ？',
    answers: [ '差額精算', '打ち切り精算', '区間変更'],
    correct: '打ち切り精算'
  }, {
    question: '第1種、第2種障害者が単独で下車してきた、片道の営業キロが100キロを超える場合の割引率として正しいのはどれ？',
    answers: [ '50%', '75%', '100%'],
    correct: '50%'
  }, {
    question: '福島からICカードで乗車してきた方が精算を求めてきた、正しい精算対応はどれ？',
    answers: [ '問答無用でICから引く', '経路を聞いてその額を引く', 'タッチすれば出れるのでタッチを促す'],
    correct: '経路を聞いてその額を引く'
  }
];
//長コードを短単語に定義
const $window = window;
const $doc = document;
const $question = $doc.getElementById('js-question');
const $buttons = $doc.querySelectorAll('.btn');

const quizLength = quiz.length;
let quizCount = 0;
let score = 0;
//問題によって表示を切り替え
const init = () => {
  $question.textContent = quiz[quizCount].question;
  
  const buttonLen = $buttons.length;
  let btnIndex = 0;
  
  while(btnIndex < buttonLen){
    $buttons[btnIndex].textContent = quiz[quizCount].answers[btnIndex];
    btnIndex++;
  }
};
//回答数により次の問題へいくか、終わらせるかの分岐
const goToNext = () => {
  quizCount++;
  if(quizCount < quizLength){
    init(quizCount);
  } else {
    showEnd();
  }
};
//正誤判定、正解ならスコアを１足して、不正解でも次の問題へ
const judge = (elm) => {
  if(elm.textContent === quiz[quizCount].correct){
    $window.alert('正解!');
    score++;
  } else {
    $window.alert('不正解!');
  }
  goToNext();
};
//終了時スコア表示をさせてボタンを隠す
const showEnd = () => {
  $question.textContent = '終了！あなたのスコアは' + score + '/' + quizLength + 'です';
  
  const $items = $doc.getElementById('js-items');
  $items.style.visibility = 'hidden';
};

init();
//問題によって選択肢を切り替え
let answersIndex = 0;
let answersLen = quiz[quizCount].answers.length;

while(answersIndex < answersLen){
  $buttons[answersIndex].addEventListener('click', (e) => {
    judge(e.target);
  });
  answersIndex++;
}