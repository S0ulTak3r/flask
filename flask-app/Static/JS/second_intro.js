const nameElem = document.querySelector('.name');
const questionElem = document.querySelector('.question');
const optionsElem = document.querySelector('.options');
const bioYesElem = document.querySelector('.bio-yes');
const bioNoElem = document.querySelector('.bio-no');
const introContainerElem = document.querySelector('.intro-container');

nameElem.style.display = 'block';
nameElem.addEventListener('animationend', () => {
    questionElem.style.display = 'block';
});

function showBio(isYes) {
    optionsElem.style.display = 'none';
    if (isYes) {
        bioYesElem.style.display = 'block';
        bioNoElem.style.display = 'none';
    } else {
        bioYesElem.style.display = 'none';
        bioNoElem.style.display = 'block';
    }
    setTimeout(() => {
        introContainerElem.style.display = 'block';
    }, 10000);
}

setTimeout(() => {
    window.location.href = "/portfolio";
}, 30000);
