$(document).ready(function(){
  $('.bxslider').bxSlider({
    auto: true,           // 自動スライド
    speed: 800,          // スライドするスピード
    moveSlides: 1,        // 移動するスライド数
    pause: 1000,          // 自動スライドの待ち時間
    maxSlides: 3,         // 一度に表示させる最大数
    slideWidth: 700,      // 各スライドの幅
	  randomStart: true,    // 最初に表示するスライドをランダムに設定
    autoHover: false,     // ホバー時に自動スライドを停止
    controls: false,
    slideMargin: 0,
    mode: 'fade',
  });
});