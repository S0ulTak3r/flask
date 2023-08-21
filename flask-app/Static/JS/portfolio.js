/* MENU SHOW */ 
const showMenu = (toggleId, navId) =>{
    const toggle = document.getElementById(toggleId),
    nav = document.getElementById(navId)

    if(toggle && nav){
        toggle.addEventListener('click', ()=>{
            nav.classList.toggle('show')
            nav.offsetHeight;  // Forces a reflow
        })
    }
}

showMenu('nav-toggle','nav-menu')

/*----- ANIMATE -----*/
// OVERLAY
gsap.to(".first", 1.5, {delay: .5, top: "-100%", ease: Expo.easeInOut});
gsap.to(".second", 1.5, {delay: .7, top: "-100%", ease: Expo.easeInOut});
gsap.to(".third", 1.5, {delay: .9, top: "-100%", ease: Expo.easeInOut});


// IMG
gsap.from('.home__img', {opacity: 0, duration: 2, delay: 2, x: 60})

// INFORMATION
gsap.from('.home__information', {opacity: 0, duration: 3, delay: 2.3, y: 25})
gsap.from('.anime-text', {opacity: 0, duration: 3, delay: 2.3, y: 25, ease:'expo.out', stagger: .3})

// NAV ITEM
gsap.from('.nav__logo', {opacity:0, duration: 3, delay: 3.2, y: 25, ease:'expo.out'});
gsap.from('.nav__item', {opacity: 0, duration: 3, delay: 3.2, y: 25, ease:'expo.out', stagger: .2})

// SOCIAL
gsap.from('.home__social-icon', {opacity: 0, duration: 3, delay: 4, y: 25, ease:'expo.out', stagger: .2})

// Typing Animation

// Find the total duration of all animations
let totalAnimationTime = 2;

// Start the typing animation after all other animations
setTimeout(function() {
    const title = document.querySelector('.home__title');
    title.classList.add('typing-animation');
}, totalAnimationTime * 1000);  // Multiply by 1000 to convert seconds to milliseconds

// Loop the typing animation every 15 seconds
setInterval(function() {
    const title = document.querySelector('.home__title');
    if (title.classList.contains('typing-animation')) {
        title.classList.remove('typing-animation');
        // Wait for the animation to reset before starting it again
        setTimeout(function() {
            title.classList.add('typing-animation');
        }, 100);
    }
}, 15000);




// Get a reference to your header and navMenu
const header = document.getElementById('myHeader');
const navMenu = document.getElementById('nav-menu');

// Listen for the scroll event on the window
window.addEventListener('scroll', () => {
    // Check if the scroll position is greater than a certain value
    if (window.scrollY > 100) {  // Change 100 to the value you want
        // If it is, add a class that slides up and fades the header
        header.classList.add('slideUp');

        // Also, if navMenu is visible, hide it
        if (navMenu.classList.contains('show')) {
            navMenu.classList.remove('show');
        }
    } else {
        // If it's not, remove the class that slides up and fades the header
        header.classList.remove('slideUp');
    }
});



// Get all the nav links
var navLinks = document.querySelectorAll('.nav__link');

// Add event listener to each link
navLinks.forEach(function(link) {
    link.addEventListener('click', function() {
        // Remove the 'show' class from the nav menu
        document.getElementById('nav-menu').classList.remove('show');
    });
});














