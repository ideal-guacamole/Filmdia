/**
 * Created by Ferriswheel on 2017/5/17.
 */

var loginBox = document.getElementById('loginBox');
var shield = document.getElementById('shield');
var userImg = document.getElementById('userCenter');

var userBox = document.getElementById('userBox');
var underBox = document.getElementById('userUnderBox');
var underBoxSignOut = underBox.getElementsByTagName('a')[2];
var underBoxSpan = underBox.getElementsByTagName('span')[0];

// var initArea = document.getElementById('initArea');
// var initInputArr = initArea.getElementsByTagName('Input');
// var initDiv = initArea.getElementsByTagName('div')[0];

var cancelBtn = document.getElementById('cancelBtn');

var signInForm = document.getElementById('signInForm');
var userText1 = document.getElementById('userText1');
var userHint1 = document.getElementById('userHint1');
var passwordText1 = document.getElementById('passwordText1');
var passwordHint1 = document.getElementById('passwordHint1');
var signInWarning = document.getElementById('signInWarning');
var toSignUp = document.getElementById('toSignUp');
var signInBtn = document.getElementById('signInSubmit');

var signUpForm = document.getElementById('signUpForm');
var userText2 = document.getElementById('userText2');
var userHint2 = document.getElementById('userHint2');
var passwordText2 = document.getElementById('passwordText2');
var passwordHint2 = document.getElementById('passwordHint2');
var passwordText3 = document.getElementById('passwordText3');
var passwordHint3 = document.getElementById('passwordHint3');
var signUpWarning = document.getElementById('signUpWarning');
var toSignIn = document.getElementById('toSignIn');
var signUpBtn = document.getElementById('signUpSubmit');

var timer = null;

function userFunction(userState, userName) {
    userImg.isSignIn = userState;
    userImg.user = userName;

    //进入登录框
    userImg.onclick = function () {
        if (!userImg.isSignIn) {
            loginBox.style.display = 'block';
            shield.style.display = 'block';
            // doOpacity(shield, 0.1, 0.7, function () {
            //     doOpacity(loginBox, 1, 1)
            // });
            // shield.style.opacity = 0.7;
            // loginBox.style.opacity = 1;

            //
            // // initArea.style.display = 'block';
            // signInForm.style.display = 'block';
            // signUpForm.style.display = 'none';
            // initInputArr[0].style.opacity = 1;
            // initInputArr[1].style.opacity = 0;
            // initDiv.style.opacity = 0;

            doOpacity(shield, 0.1, 0.7, function () {
                doOpacity(loginBox, 0.2, 1
                    // , function () {
                    // setTimeout(function () {
                    //     doOpacity(signInForm, 0.6, 1, function () {
                    //         setTimeout(function () {
                    //             doOpacity(initDiv, 0.6, 1, function () {
                    //                 setTimeout(function () {
                    //                     doOpacity(initInputArr[1], 0.6, 1);
                    //                 });
                    //             }, 100);
                    //         }, 100);
                    //     });
                    // }, 100);
                // }
                );
            });

            enterSignIn();

            shield.onclick = function () {
                doOpacity(loginBox, 0.1, 0, function () {
                    loginBox.style.display = 'none';
                });
                doOpacity(shield, 0.1, 0, function () {
                    shield.style.display = 'none';
                });
            };
        }
    };
    userImg.onmouseover = showUnderBox;
    userImg.onmouseout = hideUnderBox;
    underBox.onmouseover = showUnderBox;
    underBox.onmouseout = hideUnderBox;

    // initInputArr[0].onclick = enterSignIn;
    toSignUp.onclick = enterSignUp;

    // initInputArr[1].onclick = enterSignUp;
    toSignIn.onclick = enterSignIn;

    signInBtn.onclick = signIn;


    function signIn() {
        var userAccount = {
            userName: userText1.value,
            password: passwordText1.value
        };

        $.ajax({
            type: 'post',
            url: '/user/signIn.action',
            data: userAccount,
            //请求成功后的回调函数
            success: function (data) {
                if (data.result === 'success') {
                    userImg.isSignIn = true;
                    userImg.user = userText1.value;
                    underBoxSpan.innerHTML = userText1.value;
                    signInWarning.innerHTML = '';
                    alert("Sign In Successfully!");
                    doOpacity(loginBox, 0.1, 0, function () {
                        loginBox.style.display = 'none';
                    });
                    doOpacity(shield, 0.1, 0, function () {
                        shield.style.display = 'none';
                    });
                    window.location.reload(true);
                }
                else {
                    signInWarning.innerHTML = 'Sign In Failed';
                }
            }
        });
    }

    signUpBtn.onclick = signUp;
}

function signUp() {
    if (userText2.value === '') {
        signUpWarning.innerHTML = 'Please pick a Username'
    } else if (passwordText2.value === '') {
        signUpWarning.innerHTML = 'Please input password'
    } else if (passwordText2.value.length < 6 || passwordText2.value.length > 12) {
        signUpWarning.innerHTML = 'password should be at least 6 and at most 12 characters'
    } else if (passwordText2.value !== passwordText3.value) {
        signUpWarning.innerHTML = 'Inconsistent Passwords!';
    }
    else {
        signUpWarning.innerHTML = '';
        var userAccount = {
            userName: userText2.value,
            password: passwordText2.value
        };
        $.ajax({
            type: 'post',
            url: '/user/signUp.action',
            data: userAccount,
            //请求成功后的回调函数
            success: function (data) {
                if (data.result === 'success') {
                    userImg.isSignIn = true;
                    userImg.user = userText2.value;
                    underBoxSpan.innerHTML = userText2.value;
                    signUpWarning.innerHTML = '';
                    alert("Sign Up Successfully!");
                    doOpacity(loginBox, 0.1, 0, function () {
                        loginBox.style.display = 'none';
                    });
                    doOpacity(shield, 0.1, 0, function () {
                        shield.style.display = 'none';
                    });
                    window.location.reload(true);
                }
                else {
                    signUpWarning.innerHTML = 'Sign Up Failed';
                }
            }
        });
    }
}

//进入登录
function enterSignIn() {
    // initArea.style.display = 'none';
    signUpForm.style.display = 'none';
    signInForm.style.display = 'block';
    signInForm.style.opacity = 1;
    // doOpacity(signInForm, 0.1, 1);

    userText1.isEdit = false;
    passwordText1.isEdit = false;

    userText1.onclick = function () {
        hintClear(this);
    };
    passwordText1.onclick = function () {
        hintClear(this);
    };
}

//进入注册
function enterSignUp() {
    // initArea.style.display = 'none';
    signInForm.style.display = 'none';
    signUpForm.style.display = 'block';
    signUpForm.style.opacity = 1;
    // doOpacity(signUpForm, 0.1, 1);

    userText2.isEdit = false;
    passwordText2.isEdit = false;
    passwordText3.isEdit = false;

    userText2.onclick = function () {
        hintClear(this);
    };
    passwordText2.onclick = function () {
        hintClear(this);
    };
    passwordText3.onclick = function () {
        hintClear(this);
    };
}

//登出
function signOut() {
    $.ajax({
        type: 'get',
        url: '/user/signOut.action',
        success: function () {
            userImg.isSignIn = false;
            userImg.user = '';
            window.location.reload();
        }
    });

}

function showUnderBox() {
    if (userImg.isSignIn && userImg.user != "") {
        underBoxSpan.innerHTML = userImg.user;
        clearInterval(timer);
        underBox.style.display = 'block';
    }
}

function hideUnderBox() {
    if (userImg.isSignIn && userImg.user != "") {
        timer = setTimeout(function () {
            underBox.style.display = 'none';
        }, 200);
    }
}

function hintClear(obj) {
    if (!obj.isEdit) {
        obj.value = "";
        obj.isEdit = !obj.isEdit;
    }
}


