<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Docente - ThesisReview Portal</title>
    <meta name="description" content="Panel de control para docentes. Revisa y evalúa tesis asignadas con herramientas profesionales de evaluación académica.">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

@import url('https://fonts.googleapis.com/css2?family=Crimson+Text:wght@400;600&display=swap');

*, ::before, ::after{
  --tw-border-spacing-x: 0;
  --tw-border-spacing-y: 0;
  --tw-translate-x: 0;
  --tw-translate-y: 0;
  --tw-rotate: 0;
  --tw-skew-x: 0;
  --tw-skew-y: 0;
  --tw-scale-x: 1;
  --tw-scale-y: 1;
  --tw-pan-x:  ;
  --tw-pan-y:  ;
  --tw-pinch-zoom:  ;
  --tw-scroll-snap-strictness: proximity;
  --tw-gradient-from-position:  ;
  --tw-gradient-via-position:  ;
  --tw-gradient-to-position:  ;
  --tw-ordinal:  ;
  --tw-slashed-zero:  ;
  --tw-numeric-figure:  ;
  --tw-numeric-spacing:  ;
  --tw-numeric-fraction:  ;
  --tw-ring-inset:  ;
  --tw-ring-offset-width: 0px;
  --tw-ring-offset-color: #fff;
  --tw-ring-color: rgb(59 130 246 / 0.5);
  --tw-ring-offset-shadow: 0 0 #0000;
  --tw-ring-shadow: 0 0 #0000;
  --tw-shadow: 0 0 #0000;
  --tw-shadow-colored: 0 0 #0000;
  --tw-blur:  ;
  --tw-brightness:  ;
  --tw-contrast:  ;
  --tw-grayscale:  ;
  --tw-hue-rotate:  ;
  --tw-invert:  ;
  --tw-saturate:  ;
  --tw-sepia:  ;
  --tw-drop-shadow:  ;
  --tw-backdrop-blur:  ;
  --tw-backdrop-brightness:  ;
  --tw-backdrop-contrast:  ;
  --tw-backdrop-grayscale:  ;
  --tw-backdrop-hue-rotate:  ;
  --tw-backdrop-invert:  ;
  --tw-backdrop-opacity:  ;
  --tw-backdrop-saturate:  ;
  --tw-backdrop-sepia:  ;
  --tw-contain-size:  ;
  --tw-contain-layout:  ;
  --tw-contain-paint:  ;
  --tw-contain-style:  ;
}

::backdrop{
  --tw-border-spacing-x: 0;
  --tw-border-spacing-y: 0;
  --tw-translate-x: 0;
  --tw-translate-y: 0;
  --tw-rotate: 0;
  --tw-skew-x: 0;
  --tw-skew-y: 0;
  --tw-scale-x: 1;
  --tw-scale-y: 1;
  --tw-pan-x:  ;
  --tw-pan-y:  ;
  --tw-pinch-zoom:  ;
  --tw-scroll-snap-strictness: proximity;
  --tw-gradient-from-position:  ;
  --tw-gradient-via-position:  ;
  --tw-gradient-to-position:  ;
  --tw-ordinal:  ;
  --tw-slashed-zero:  ;
  --tw-numeric-figure:  ;
  --tw-numeric-spacing:  ;
  --tw-numeric-fraction:  ;
  --tw-ring-inset:  ;
  --tw-ring-offset-width: 0px;
  --tw-ring-offset-color: #fff;
  --tw-ring-color: rgb(59 130 246 / 0.5);
  --tw-ring-offset-shadow: 0 0 #0000;
  --tw-ring-shadow: 0 0 #0000;
  --tw-shadow: 0 0 #0000;
  --tw-shadow-colored: 0 0 #0000;
  --tw-blur:  ;
  --tw-brightness:  ;
  --tw-contrast:  ;
  --tw-grayscale:  ;
  --tw-hue-rotate:  ;
  --tw-invert:  ;
  --tw-saturate:  ;
  --tw-sepia:  ;
  --tw-drop-shadow:  ;
  --tw-backdrop-blur:  ;
  --tw-backdrop-brightness:  ;
  --tw-backdrop-contrast:  ;
  --tw-backdrop-grayscale:  ;
  --tw-backdrop-hue-rotate:  ;
  --tw-backdrop-invert:  ;
  --tw-backdrop-opacity:  ;
  --tw-backdrop-saturate:  ;
  --tw-backdrop-sepia:  ;
  --tw-contain-size:  ;
  --tw-contain-layout:  ;
  --tw-contain-paint:  ;
  --tw-contain-style:  ;
}

/*
! tailwindcss v3.4.17 | MIT License | https://tailwindcss.com
*/

/*
1. Prevent padding and border from affecting element width. (https://github.com/mozdevs/cssremedy/issues/4)
2. Allow adding a border to an element by just adding a border-width. (https://github.com/tailwindcss/tailwindcss/pull/116)
*/

*,
::before,
::after {
  box-sizing: border-box;
  /* 1 */
  border-width: 0;
  /* 2 */
  border-style: solid;
  /* 2 */
  border-color: #e5e7eb;
  /* 2 */
}

::before,
::after {
  --tw-content: '';
}

/*
1. Use a consistent sensible line-height in all browsers.
2. Prevent adjustments of font size after orientation changes in iOS.
3. Use a more readable tab size.
4. Use the user's configured `sans` font-family by default.
5. Use the user's configured `sans` font-feature-settings by default.
6. Use the user's configured `sans` font-variation-settings by default.
7. Disable tap highlights on iOS
*/

html,
:host {
  line-height: 1.5;
  /* 1 */
  -webkit-text-size-adjust: 100%;
  /* 2 */
  -moz-tab-size: 4;
  /* 3 */
  -o-tab-size: 4;
     tab-size: 4;
  /* 3 */
  font-family: Inter, sans-serif;
  /* 4 */
  font-feature-settings: normal;
  /* 5 */
  font-variation-settings: normal;
  /* 6 */
  -webkit-tap-highlight-color: transparent;
  /* 7 */
}

/*
1. Remove the margin in all browsers.
2. Inherit line-height from `html` so users can set them as a class directly on the `html` element.
*/

body {
  margin: 0;
  /* 1 */
  line-height: inherit;
  /* 2 */
}

/*
1. Add the correct height in Firefox.
2. Correct the inheritance of border color in Firefox. (https://bugzilla.mozilla.org/show_bug.cgi?id=190655)
3. Ensure horizontal rules are visible by default.
*/

hr {
  height: 0;
  /* 1 */
  color: inherit;
  /* 2 */
  border-top-width: 1px;
  /* 3 */
}

/*
Add the correct text decoration in Chrome, Edge, and Safari.
*/

abbr:where([title]) {
  -webkit-text-decoration: underline dotted;
          text-decoration: underline dotted;
}

/*
Remove the default font size and weight for headings.
*/

h1,
h2,
h3,
h4,
h5,
h6 {
  font-size: inherit;
  font-weight: inherit;
}

/*
Reset links to optimize for opt-in styling instead of opt-out.
*/

a {
  color: inherit;
  text-decoration: inherit;
}

/*
Add the correct font weight in Edge and Safari.
*/

b,
strong {
  font-weight: bolder;
}

/*
1. Use the user's configured `mono` font-family by default.
2. Use the user's configured `mono` font-feature-settings by default.
3. Use the user's configured `mono` font-variation-settings by default.
4. Correct the odd `em` font sizing in all browsers.
*/

code,
kbd,
samp,
pre {
  font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
  /* 1 */
  font-feature-settings: normal;
  /* 2 */
  font-variation-settings: normal;
  /* 3 */
  font-size: 1em;
  /* 4 */
}

/*
Add the correct font size in all browsers.
*/

small {
  font-size: 80%;
}

/*
Prevent `sub` and `sup` elements from affecting the line height in all browsers.
*/

sub,
sup {
  font-size: 75%;
  line-height: 0;
  position: relative;
  vertical-align: baseline;
}

sub {
  bottom: -0.25em;
}

sup {
  top: -0.5em;
}

/*
1. Remove text indentation from table contents in Chrome and Safari. (https://bugs.chromium.org/p/chromium/issues/detail?id=999088, https://bugs.webkit.org/show_bug.cgi?id=201297)
2. Correct table border color inheritance in all Chrome and Safari. (https://bugs.chromium.org/p/chromium/issues/detail?id=935729, https://bugs.webkit.org/show_bug.cgi?id=195016)
3. Remove gaps between table borders by default.
*/

table {
  text-indent: 0;
  /* 1 */
  border-color: inherit;
  /* 2 */
  border-collapse: collapse;
  /* 3 */
}

/*
1. Change the font styles in all browsers.
2. Remove the margin in Firefox and Safari.
3. Remove default padding in all browsers.
*/

button,
input,
optgroup,
select,
textarea {
  font-family: inherit;
  /* 1 */
  font-feature-settings: inherit;
  /* 1 */
  font-variation-settings: inherit;
  /* 1 */
  font-size: 100%;
  /* 1 */
  font-weight: inherit;
  /* 1 */
  line-height: inherit;
  /* 1 */
  letter-spacing: inherit;
  /* 1 */
  color: inherit;
  /* 1 */
  margin: 0;
  /* 2 */
  padding: 0;
  /* 3 */
}

/*
Remove the inheritance of text transform in Edge and Firefox.
*/

button,
select {
  text-transform: none;
}

/*
1. Correct the inability to style clickable types in iOS and Safari.
2. Remove default button styles.
*/

button,
input:where([type='button']),
input:where([type='reset']),
input:where([type='submit']) {
  -webkit-appearance: button;
  /* 1 */
  background-color: transparent;
  /* 2 */
  background-image: none;
  /* 2 */
}

/*
Use the modern Firefox focus style for all focusable elements.
*/

:-moz-focusring {
  outline: auto;
}

/*
Remove the additional `:invalid` styles in Firefox. (https://github.com/mozilla/gecko-dev/blob/2f9eacd9d3d995c937b4251a5557d95d494c9be1/layout/style/res/forms.css#L728-L737)
*/

:-moz-ui-invalid {
  box-shadow: none;
}

/*
Add the correct vertical alignment in Chrome and Firefox.
*/

progress {
  vertical-align: baseline;
}

/*
Correct the cursor style of increment and decrement buttons in Safari.
*/

::-webkit-inner-spin-button,
::-webkit-outer-spin-button {
  height: auto;
}

/*
1. Correct the odd appearance in Chrome and Safari.
2. Correct the outline style in Safari.
*/

[type='search'] {
  -webkit-appearance: textfield;
  /* 1 */
  outline-offset: -2px;
  /* 2 */
}

/*
Remove the inner padding in Chrome and Safari on macOS.
*/

::-webkit-search-decoration {
  -webkit-appearance: none;
}

/*
1. Correct the inability to style clickable types in iOS and Safari.
2. Change font properties to `inherit` in Safari.
*/

::-webkit-file-upload-button {
  -webkit-appearance: button;
  /* 1 */
  font: inherit;
  /* 2 */
}

/*
Add the correct display in Chrome and Safari.
*/

summary {
  display: list-item;
}

/*
Removes the default spacing and border for appropriate elements.
*/

blockquote,
dl,
dd,
h1,
h2,
h3,
h4,
h5,
h6,
hr,
figure,
p,
pre {
  margin: 0;
}

fieldset {
  margin: 0;
  padding: 0;
}

legend {
  padding: 0;
}

ol,
ul,
menu {
  list-style: none;
  margin: 0;
  padding: 0;
}

/*
Reset default styling for dialogs.
*/

dialog {
  padding: 0;
}

/*
Prevent resizing textareas horizontally by default.
*/

textarea {
  resize: vertical;
}

/*
1. Reset the default placeholder opacity in Firefox. (https://github.com/tailwindlabs/tailwindcss/issues/3300)
2. Set the default placeholder color to the user's configured gray 400 color.
*/

input::-moz-placeholder, textarea::-moz-placeholder {
  opacity: 1;
  /* 1 */
  color: #9ca3af;
  /* 2 */
}

input::placeholder,
textarea::placeholder {
  opacity: 1;
  /* 1 */
  color: #9ca3af;
  /* 2 */
}

/*
Set the default cursor for buttons.
*/

button,
[role="button"] {
  cursor: pointer;
}

/*
Make sure disabled buttons don't get the pointer cursor.
*/

:disabled {
  cursor: default;
}

/*
1. Make replaced elements `display: block` by default. (https://github.com/mozdevs/cssremedy/issues/14)
2. Add `vertical-align: middle` to align replaced elements more sensibly by default. (https://github.com/jensimmons/cssremedy/issues/14#issuecomment-634934210)
   This can trigger a poorly considered lint error in some tools but is included by design.
*/

img,
svg,
video,
canvas,
audio,
iframe,
embed,
object {
  display: block;
  /* 1 */
  vertical-align: middle;
  /* 2 */
}

/*
Constrain images and videos to the parent width and preserve their intrinsic aspect ratio. (https://github.com/mozdevs/cssremedy/issues/14)
*/

img,
video {
  max-width: 100%;
  height: auto;
}

/* Make elements with the HTML hidden attribute stay hidden by default */

[hidden]:where(:not([hidden="until-found"])) {
  display: none;
}

.btn-primary{
  border-radius: 0.5rem;
  --tw-bg-opacity: 1;
  background-color: rgb(30 64 175 / var(--tw-bg-opacity, 1));
  padding-left: 1.5rem;
  padding-right: 1.5rem;
  padding-top: 0.75rem;
  padding-bottom: 0.75rem;
  font-weight: 600;
  --tw-text-opacity: 1;
  color: rgb(255 255 255 / var(--tw-text-opacity, 1));
  transition-property: all;
  transition-duration: 250ms;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
}

.btn-primary:hover{
  --tw-bg-opacity: 1;
  background-color: rgb(29 78 216 / var(--tw-bg-opacity, 1));
}

.btn-primary:focus{
  outline: 2px solid transparent;
  outline-offset: 2px;
  --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);
  --tw-ring-shadow: var(--tw-ring-inset) 0 0 0 calc(2px + var(--tw-ring-offset-width)) var(--tw-ring-color);
  box-shadow: var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow, 0 0 #0000);
  --tw-ring-opacity: 1;
  --tw-ring-color: rgb(59 130 246 / var(--tw-ring-opacity, 1));
  --tw-ring-offset-width: 2px;
}

.btn-primary {
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.btn-secondary{
  border-radius: 0.5rem;
  --tw-bg-opacity: 1;
  background-color: rgb(59 130 246 / var(--tw-bg-opacity, 1));
  padding-left: 1.5rem;
  padding-right: 1.5rem;
  padding-top: 0.75rem;
  padding-bottom: 0.75rem;
  font-weight: 600;
  --tw-text-opacity: 1;
  color: rgb(255 255 255 / var(--tw-text-opacity, 1));
  transition-property: all;
  transition-duration: 250ms;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
}

.btn-secondary:hover{
  --tw-bg-opacity: 1;
  background-color: rgb(29 78 216 / var(--tw-bg-opacity, 1));
}

.btn-secondary:focus{
  outline: 2px solid transparent;
  outline-offset: 2px;
  --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);
  --tw-ring-shadow: var(--tw-ring-inset) 0 0 0 calc(2px + var(--tw-ring-offset-width)) var(--tw-ring-color);
  box-shadow: var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow, 0 0 #0000);
  --tw-ring-opacity: 1;
  --tw-ring-color: rgb(59 130 246 / var(--tw-ring-opacity, 1));
  --tw-ring-offset-width: 2px;
}

.btn-secondary {
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.btn-accent{
  border-radius: 0.5rem;
  --tw-bg-opacity: 1;
  background-color: rgb(249 115 22 / var(--tw-bg-opacity, 1));
  padding-left: 1.5rem;
  padding-right: 1.5rem;
  padding-top: 0.75rem;
  padding-bottom: 0.75rem;
  font-weight: 600;
  --tw-text-opacity: 1;
  color: rgb(255 255 255 / var(--tw-text-opacity, 1));
  transition-property: all;
  transition-duration: 250ms;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
}

.btn-accent:hover{
  --tw-bg-opacity: 1;
  background-color: rgb(234 88 12 / var(--tw-bg-opacity, 1));
}

.btn-accent:focus{
  outline: 2px solid transparent;
  outline-offset: 2px;
  --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);
  --tw-ring-shadow: var(--tw-ring-inset) 0 0 0 calc(2px + var(--tw-ring-offset-width)) var(--tw-ring-color);
  box-shadow: var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow, 0 0 #0000);
  --tw-ring-opacity: 1;
  --tw-ring-color: rgb(249 115 22 / var(--tw-ring-opacity, 1));
  --tw-ring-offset-width: 2px;
}

.btn-accent {
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.card{
  border-radius: 0.5rem;
  border-width: 1px;
  --tw-border-opacity: 1;
  border-color: rgb(229 231 235 / var(--tw-border-opacity, 1));
  --tw-bg-opacity: 1;
  background-color: rgb(255 255 255 / var(--tw-bg-opacity, 1));
  padding: 1.5rem;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.form-input{
  width: 100%;
  border-radius: 0.375rem;
  border-width: 1px;
  --tw-border-opacity: 1;
  border-color: rgb(229 231 235 / var(--tw-border-opacity, 1));
  padding-left: 0.75rem;
  padding-right: 0.75rem;
  padding-top: 0.5rem;
  padding-bottom: 0.5rem;
  transition-property: all;
  transition-duration: 250ms;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
}

.form-input:focus{
  border-color: transparent;
  outline: 2px solid transparent;
  outline-offset: 2px;
  --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);
  --tw-ring-shadow: var(--tw-ring-inset) 0 0 0 calc(2px + var(--tw-ring-offset-width)) var(--tw-ring-color);
  box-shadow: var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow, 0 0 #0000);
  --tw-ring-opacity: 1;
  --tw-ring-color: rgb(59 130 246 / var(--tw-ring-opacity, 1));
}

.testimonial-card{
  border-radius: 0.5rem;
  border-width: 1px;
  --tw-border-opacity: 1;
  border-color: rgb(229 231 235 / var(--tw-border-opacity, 1));
  --tw-bg-opacity: 1;
  background-color: rgb(255 255 255 / var(--tw-bg-opacity, 1));
  padding: 1.5rem;
  font-family: Crimson Text, serif;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.static{
  position: static;
}

.fixed{
  position: fixed;
}

.absolute{
  position: absolute;
}

.relative{
  position: relative;
}

.sticky{
  position: sticky;
}

.inset-0{
  inset: 0px;
}

.-right-1{
  right: -0.25rem;
}

.-top-1{
  top: -0.25rem;
}

.-top-3{
  top: -0.75rem;
}

.left-1\/2{
  left: 50%;
}

.right-4{
  right: 1rem;
}

.top-0{
  top: 0px;
}

.top-4{
  top: 1rem;
}

.z-50{
  z-index: 50;
}

.mx-4{
  margin-left: 1rem;
  margin-right: 1rem;
}

.mx-auto{
  margin-left: auto;
  margin-right: auto;
}

.-mb-px{
  margin-bottom: -1px;
}

.mb-1{
  margin-bottom: 0.25rem;
}

.mb-12{
  margin-bottom: 3rem;
}

.mb-16{
  margin-bottom: 4rem;
}

.mb-2{
  margin-bottom: 0.5rem;
}

.mb-3{
  margin-bottom: 0.75rem;
}

.mb-4{
  margin-bottom: 1rem;
}

.mb-6{
  margin-bottom: 1.5rem;
}

.mb-8{
  margin-bottom: 2rem;
}

.ml-2{
  margin-left: 0.5rem;
}

.ml-3{
  margin-left: 0.75rem;
}

.ml-4{
  margin-left: 1rem;
}

.mr-1{
  margin-right: 0.25rem;
}

.mr-2{
  margin-right: 0.5rem;
}

.mr-3{
  margin-right: 0.75rem;
}

.mr-4{
  margin-right: 1rem;
}

.mt-1{
  margin-top: 0.25rem;
}

.mt-12{
  margin-top: 3rem;
}

.mt-2{
  margin-top: 0.5rem;
}

.mt-3{
  margin-top: 0.75rem;
}

.mt-4{
  margin-top: 1rem;
}

.mt-6{
  margin-top: 1.5rem;
}

.line-clamp-2{
  overflow: hidden;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
}

.block{
  display: block;
}

.inline{
  display: inline;
}

.flex{
  display: flex;
}

.inline-flex{
  display: inline-flex;
}

.table{
  display: table;
}

.grid{
  display: grid;
}

.hidden{
  display: none;
}

.h-10{
  height: 2.5rem;
}

.h-12{
  height: 3rem;
}

.h-14{
  height: 3.5rem;
}

.h-16{
  height: 4rem;
}

.h-2{
  height: 0.5rem;
}

.h-3{
  height: 0.75rem;
}

.h-4{
  height: 1rem;
}

.h-5{
  height: 1.25rem;
}

.h-6{
  height: 1.5rem;
}

.h-8{
  height: 2rem;
}

.min-h-screen{
  min-height: 100vh;
}

.w-10{
  width: 2.5rem;
}

.w-12{
  width: 3rem;
}

.w-16{
  width: 4rem;
}

.w-2{
  width: 0.5rem;
}

.w-20{
  width: 5rem;
}

.w-3{
  width: 0.75rem;
}

.w-4{
  width: 1rem;
}

.w-5{
  width: 1.25rem;
}

.w-6{
  width: 1.5rem;
}

.w-8{
  width: 2rem;
}

.w-full{
  width: 100%;
}

.min-w-full{
  min-width: 100%;
}

.max-w-3xl{
  max-width: 48rem;
}

.max-w-4xl{
  max-width: 56rem;
}

.max-w-7xl{
  max-width: 80rem;
}

.max-w-md{
  max-width: 28rem;
}

.max-w-sm{
  max-width: 24rem;
}

.max-w-xs{
  max-width: 20rem;
}

.flex-1{
  flex: 1 1 0%;
}

.flex-shrink-0{
  flex-shrink: 0;
}

.-translate-x-1\/2{
  --tw-translate-x: -50%;
  transform: translate(var(--tw-translate-x), var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y));
}

.translate-x-full{
  --tw-translate-x: 100%;
  transform: translate(var(--tw-translate-x), var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y));
}

.transform{
  transform: translate(var(--tw-translate-x), var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y));
}

@keyframes pulse{
  50%{
    opacity: .5;
  }
}

.animate-pulse{
  animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}

.cursor-pointer{
  cursor: pointer;
}

.grid-cols-1{
  grid-template-columns: repeat(1, minmax(0, 1fr));
}

.grid-cols-2{
  grid-template-columns: repeat(2, minmax(0, 1fr));
}

.grid-cols-3{
  grid-template-columns: repeat(3, minmax(0, 1fr));
}

.flex-col{
  flex-direction: column;
}

.items-start{
  align-items: flex-start;
}

.items-end{
  align-items: flex-end;
}

.items-center{
  align-items: center;
}

.justify-end{
  justify-content: flex-end;
}

.justify-center{
  justify-content: center;
}

.justify-between{
  justify-content: space-between;
}

.gap-12{
  gap: 3rem;
}

.gap-2{
  gap: 0.5rem;
}

.gap-3{
  gap: 0.75rem;
}

.gap-4{
  gap: 1rem;
}

.gap-6{
  gap: 1.5rem;
}

.gap-8{
  gap: 2rem;
}

.space-x-1 > :not([hidden]) ~ :not([hidden]){
  --tw-space-x-reverse: 0;
  margin-right: calc(0.25rem * var(--tw-space-x-reverse));
  margin-left: calc(0.25rem * calc(1 - var(--tw-space-x-reverse)));
}

.space-x-2 > :not([hidden]) ~ :not([hidden]){
  --tw-space-x-reverse: 0;
  margin-right: calc(0.5rem * var(--tw-space-x-reverse));
  margin-left: calc(0.5rem * calc(1 - var(--tw-space-x-reverse)));
}

.space-x-3 > :not([hidden]) ~ :not([hidden]){
  --tw-space-x-reverse: 0;
  margin-right: calc(0.75rem * var(--tw-space-x-reverse));
  margin-left: calc(0.75rem * calc(1 - var(--tw-space-x-reverse)));
}

.space-x-4 > :not([hidden]) ~ :not([hidden]){
  --tw-space-x-reverse: 0;
  margin-right: calc(1rem * var(--tw-space-x-reverse));
  margin-left: calc(1rem * calc(1 - var(--tw-space-x-reverse)));
}

.space-x-6 > :not([hidden]) ~ :not([hidden]){
  --tw-space-x-reverse: 0;
  margin-right: calc(1.5rem * var(--tw-space-x-reverse));
  margin-left: calc(1.5rem * calc(1 - var(--tw-space-x-reverse)));
}

.space-x-8 > :not([hidden]) ~ :not([hidden]){
  --tw-space-x-reverse: 0;
  margin-right: calc(2rem * var(--tw-space-x-reverse));
  margin-left: calc(2rem * calc(1 - var(--tw-space-x-reverse)));
}

.space-y-2 > :not([hidden]) ~ :not([hidden]){
  --tw-space-y-reverse: 0;
  margin-top: calc(0.5rem * calc(1 - var(--tw-space-y-reverse)));
  margin-bottom: calc(0.5rem * var(--tw-space-y-reverse));
}

.space-y-3 > :not([hidden]) ~ :not([hidden]){
  --tw-space-y-reverse: 0;
  margin-top: calc(0.75rem * calc(1 - var(--tw-space-y-reverse)));
  margin-bottom: calc(0.75rem * var(--tw-space-y-reverse));
}

.space-y-4 > :not([hidden]) ~ :not([hidden]){
  --tw-space-y-reverse: 0;
  margin-top: calc(1rem * calc(1 - var(--tw-space-y-reverse)));
  margin-bottom: calc(1rem * var(--tw-space-y-reverse));
}

.space-y-6 > :not([hidden]) ~ :not([hidden]){
  --tw-space-y-reverse: 0;
  margin-top: calc(1.5rem * calc(1 - var(--tw-space-y-reverse)));
  margin-bottom: calc(1.5rem * var(--tw-space-y-reverse));
}

.space-y-8 > :not([hidden]) ~ :not([hidden]){
  --tw-space-y-reverse: 0;
  margin-top: calc(2rem * calc(1 - var(--tw-space-y-reverse)));
  margin-bottom: calc(2rem * var(--tw-space-y-reverse));
}

.divide-y > :not([hidden]) ~ :not([hidden]){
  --tw-divide-y-reverse: 0;
  border-top-width: calc(1px * calc(1 - var(--tw-divide-y-reverse)));
  border-bottom-width: calc(1px * var(--tw-divide-y-reverse));
}

.divide-gray-200 > :not([hidden]) ~ :not([hidden]){
  --tw-divide-opacity: 1;
  border-color: rgb(229 231 235 / var(--tw-divide-opacity, 1));
}

.overflow-hidden{
  overflow: hidden;
}

.overflow-x-auto{
  overflow-x: auto;
}

.truncate{
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.whitespace-nowrap{
  white-space: nowrap;
}

.rounded{
  border-radius: 0.25rem;
}

.rounded-2xl{
  border-radius: 1rem;
}

.rounded-full{
  border-radius: 9999px;
}

.rounded-lg{
  border-radius: 0.5rem;
}

.rounded-md{
  border-radius: 0.375rem;
}

.rounded-sm{
  border-radius: 0.125rem;
}

.rounded-xl{
  border-radius: 0.75rem;
}

.rounded-r-lg{
  border-top-right-radius: 0.5rem;
  border-bottom-right-radius: 0.5rem;
}

.border{
  border-width: 1px;
}

.border-2{
  border-width: 2px;
}

.border-b{
  border-bottom-width: 1px;
}

.border-b-2{
  border-bottom-width: 2px;
}

.border-l-4{
  border-left-width: 4px;
}

.border-r{
  border-right-width: 1px;
}

.border-t{
  border-top-width: 1px;
}

.border-dashed{
  border-style: dashed;
}

.border-accent{
  --tw-border-opacity: 1;
  border-color: rgb(249 115 22 / var(--tw-border-opacity, 1));
}

.border-accent-200{
  --tw-border-opacity: 1;
  border-color: rgb(254 215 170 / var(--tw-border-opacity, 1));
}

.border-error{
  --tw-border-opacity: 1;
  border-color: rgb(239 68 68 / var(--tw-border-opacity, 1));
}

.border-gray-200{
  --tw-border-opacity: 1;
  border-color: rgb(229 231 235 / var(--tw-border-opacity, 1));
}

.border-primary{
  --tw-border-opacity: 1;
  border-color: rgb(30 64 175 / var(--tw-border-opacity, 1));
}

.border-primary-200{
  --tw-border-opacity: 1;
  border-color: rgb(191 219 254 / var(--tw-border-opacity, 1));
}

.border-primary-300{
  --tw-border-opacity: 1;
  border-color: rgb(147 197 253 / var(--tw-border-opacity, 1));
}

.border-primary-400{
  --tw-border-opacity: 1;
  border-color: rgb(96 165 250 / var(--tw-border-opacity, 1));
}

.border-primary-700{
  --tw-border-opacity: 1;
  border-color: rgb(29 78 216 / var(--tw-border-opacity, 1));
}

.border-secondary-200{
  --tw-border-opacity: 1;
  border-color: rgb(191 219 254 / var(--tw-border-opacity, 1));
}

.border-success{
  --tw-border-opacity: 1;
  border-color: rgb(16 185 129 / var(--tw-border-opacity, 1));
}

.border-transparent{
  border-color: transparent;
}

.border-warning{
  --tw-border-opacity: 1;
  border-color: rgb(245 158 11 / var(--tw-border-opacity, 1));
}

.bg-accent{
  --tw-bg-opacity: 1;
  background-color: rgb(249 115 22 / var(--tw-bg-opacity, 1));
}

.bg-accent-100{
  --tw-bg-opacity: 1;
  background-color: rgb(255 237 213 / var(--tw-bg-opacity, 1));
}

.bg-accent-50{
  --tw-bg-opacity: 1;
  background-color: rgb(255 247 237 / var(--tw-bg-opacity, 1));
}

.bg-background{
  --tw-bg-opacity: 1;
  background-color: rgb(255 255 255 / var(--tw-bg-opacity, 1));
}

.bg-black{
  --tw-bg-opacity: 1;
  background-color: rgb(0 0 0 / var(--tw-bg-opacity, 1));
}

.bg-error{
  --tw-bg-opacity: 1;
  background-color: rgb(239 68 68 / var(--tw-bg-opacity, 1));
}

.bg-error-100{
  --tw-bg-opacity: 1;
  background-color: rgb(254 226 226 / var(--tw-bg-opacity, 1));
}

.bg-error-50{
  --tw-bg-opacity: 1;
  background-color: rgb(254 242 242 / var(--tw-bg-opacity, 1));
}

.bg-gray-200{
  --tw-bg-opacity: 1;
  background-color: rgb(229 231 235 / var(--tw-bg-opacity, 1));
}

.bg-gray-300{
  --tw-bg-opacity: 1;
  background-color: rgb(209 213 219 / var(--tw-bg-opacity, 1));
}

.bg-gray-400{
  --tw-bg-opacity: 1;
  background-color: rgb(156 163 175 / var(--tw-bg-opacity, 1));
}

.bg-gray-50{
  --tw-bg-opacity: 1;
  background-color: rgb(249 250 251 / var(--tw-bg-opacity, 1));
}

.bg-gray-600{
  --tw-bg-opacity: 1;
  background-color: rgb(75 85 99 / var(--tw-bg-opacity, 1));
}

.bg-primary{
  --tw-bg-opacity: 1;
  background-color: rgb(30 64 175 / var(--tw-bg-opacity, 1));
}

.bg-primary-100{
  --tw-bg-opacity: 1;
  background-color: rgb(219 234 254 / var(--tw-bg-opacity, 1));
}

.bg-primary-200{
  --tw-bg-opacity: 1;
  background-color: rgb(191 219 254 / var(--tw-bg-opacity, 1));
}

.bg-primary-300{
  --tw-bg-opacity: 1;
  background-color: rgb(147 197 253 / var(--tw-bg-opacity, 1));
}

.bg-primary-400{
  --tw-bg-opacity: 1;
  background-color: rgb(96 165 250 / var(--tw-bg-opacity, 1));
}

.bg-primary-50{
  --tw-bg-opacity: 1;
  background-color: rgb(239 246 255 / var(--tw-bg-opacity, 1));
}

.bg-primary-500{
  --tw-bg-opacity: 1;
  background-color: rgb(59 130 246 / var(--tw-bg-opacity, 1));
}

.bg-primary-600{
  --tw-bg-opacity: 1;
  background-color: rgb(37 99 235 / var(--tw-bg-opacity, 1));
}

.bg-secondary{
  --tw-bg-opacity: 1;
  background-color: rgb(59 130 246 / var(--tw-bg-opacity, 1));
}

.bg-secondary-100{
  --tw-bg-opacity: 1;
  background-color: rgb(219 234 254 / var(--tw-bg-opacity, 1));
}

.bg-secondary-50{
  --tw-bg-opacity: 1;
  background-color: rgb(239 246 255 / var(--tw-bg-opacity, 1));
}

.bg-success{
  --tw-bg-opacity: 1;
  background-color: rgb(16 185 129 / var(--tw-bg-opacity, 1));
}

.bg-success-100{
  --tw-bg-opacity: 1;
  background-color: rgb(209 250 229 / var(--tw-bg-opacity, 1));
}

.bg-success-50{
  --tw-bg-opacity: 1;
  background-color: rgb(236 253 245 / var(--tw-bg-opacity, 1));
}

.bg-surface{
  --tw-bg-opacity: 1;
  background-color: rgb(248 250 252 / var(--tw-bg-opacity, 1));
}

.bg-warning{
  --tw-bg-opacity: 1;
  background-color: rgb(245 158 11 / var(--tw-bg-opacity, 1));
}

.bg-warning-100{
  --tw-bg-opacity: 1;
  background-color: rgb(254 243 199 / var(--tw-bg-opacity, 1));
}

.bg-warning-50{
  --tw-bg-opacity: 1;
  background-color: rgb(255 251 235 / var(--tw-bg-opacity, 1));
}

.bg-white{
  --tw-bg-opacity: 1;
  background-color: rgb(255 255 255 / var(--tw-bg-opacity, 1));
}

.bg-opacity-20{
  --tw-bg-opacity: 0.2;
}

.bg-opacity-50{
  --tw-bg-opacity: 0.5;
}

.bg-gradient-to-br{
  background-image: linear-gradient(to bottom right, var(--tw-gradient-stops));
}

.bg-gradient-to-r{
  background-image: linear-gradient(to right, var(--tw-gradient-stops));
}

.from-primary{
  --tw-gradient-from: #1e40af var(--tw-gradient-from-position);
  --tw-gradient-to: rgb(30 64 175 / 0) var(--tw-gradient-to-position);
  --tw-gradient-stops: var(--tw-gradient-from), var(--tw-gradient-to);
}

.from-primary-50{
  --tw-gradient-from: #eff6ff var(--tw-gradient-from-position);
  --tw-gradient-to: rgb(239 246 255 / 0) var(--tw-gradient-to-position);
  --tw-gradient-stops: var(--tw-gradient-from), var(--tw-gradient-to);
}

.from-secondary{
  --tw-gradient-from: #3b82f6 var(--tw-gradient-from-position);
  --tw-gradient-to: rgb(59 130 246 / 0) var(--tw-gradient-to-position);
  --tw-gradient-stops: var(--tw-gradient-from), var(--tw-gradient-to);
}

.to-accent{
  --tw-gradient-to: #f97316 var(--tw-gradient-to-position);
}

.to-secondary{
  --tw-gradient-to: #3b82f6 var(--tw-gradient-to-position);
}

.to-secondary-100{
  --tw-gradient-to: #dbeafe var(--tw-gradient-to-position);
}

.object-cover{
  -o-object-fit: cover;
     object-fit: cover;
}

.p-1{
  padding: 0.25rem;
}

.p-2{
  padding: 0.5rem;
}

.p-3{
  padding: 0.75rem;
}

.p-4{
  padding: 1rem;
}

.p-6{
  padding: 1.5rem;
}

.p-8{
  padding: 2rem;
}

.px-1{
  padding-left: 0.25rem;
  padding-right: 0.25rem;
}

.px-2{
  padding-left: 0.5rem;
  padding-right: 0.5rem;
}

.px-2\.5{
  padding-left: 0.625rem;
  padding-right: 0.625rem;
}

.px-3{
  padding-left: 0.75rem;
  padding-right: 0.75rem;
}

.px-4{
  padding-left: 1rem;
  padding-right: 1rem;
}

.px-6{
  padding-left: 1.5rem;
  padding-right: 1.5rem;
}

.px-8{
  padding-left: 2rem;
  padding-right: 2rem;
}

.py-0\.5{
  padding-top: 0.125rem;
  padding-bottom: 0.125rem;
}

.py-1{
  padding-top: 0.25rem;
  padding-bottom: 0.25rem;
}

.py-16{
  padding-top: 4rem;
  padding-bottom: 4rem;
}

.py-2{
  padding-top: 0.5rem;
  padding-bottom: 0.5rem;
}

.py-20{
  padding-top: 5rem;
  padding-bottom: 5rem;
}

.py-3{
  padding-top: 0.75rem;
  padding-bottom: 0.75rem;
}

.py-4{
  padding-top: 1rem;
  padding-bottom: 1rem;
}

.py-8{
  padding-top: 2rem;
  padding-bottom: 2rem;
}

.pl-4{
  padding-left: 1rem;
}

.pt-4{
  padding-top: 1rem;
}

.pt-8{
  padding-top: 2rem;
}

.text-left{
  text-align: left;
}

.text-center{
  text-align: center;
}

.text-right{
  text-align: right;
}

.font-inter{
  font-family: Inter, sans-serif;
}

.text-2xl{
  font-size: 1.5rem;
  line-height: 2rem;
}

.text-3xl{
  font-size: 1.875rem;
  line-height: 2.25rem;
}

.text-4xl{
  font-size: 2.25rem;
  line-height: 2.5rem;
}

.text-base{
  font-size: 1rem;
  line-height: 1.5rem;
}

.text-lg{
  font-size: 1.125rem;
  line-height: 1.75rem;
}

.text-sm{
  font-size: 0.875rem;
  line-height: 1.25rem;
}

.text-xl{
  font-size: 1.25rem;
  line-height: 1.75rem;
}

.text-xs{
  font-size: 0.75rem;
  line-height: 1rem;
}

.font-bold{
  font-weight: 700;
}

.font-medium{
  font-weight: 500;
}

.font-semibold{
  font-weight: 600;
}

.uppercase{
  text-transform: uppercase;
}

.italic{
  font-style: italic;
}

.leading-relaxed{
  line-height: 1.625;
}

.leading-tight{
  line-height: 1.25;
}

.text-accent{
  --tw-text-opacity: 1;
  color: rgb(249 115 22 / var(--tw-text-opacity, 1));
}

.text-error{
  --tw-text-opacity: 1;
  color: rgb(239 68 68 / var(--tw-text-opacity, 1));
}

.text-gray-400{
  --tw-text-opacity: 1;
  color: rgb(156 163 175 / var(--tw-text-opacity, 1));
}

.text-gray-500{
  --tw-text-opacity: 1;
  color: rgb(107 114 128 / var(--tw-text-opacity, 1));
}

.text-gray-600{
  --tw-text-opacity: 1;
  color: rgb(75 85 99 / var(--tw-text-opacity, 1));
}

.text-gray-700{
  --tw-text-opacity: 1;
  color: rgb(55 65 81 / var(--tw-text-opacity, 1));
}

.text-gray-900{
  --tw-text-opacity: 1;
  color: rgb(17 24 39 / var(--tw-text-opacity, 1));
}

.text-primary{
  --tw-text-opacity: 1;
  color: rgb(30 64 175 / var(--tw-text-opacity, 1));
}

.text-primary-200{
  --tw-text-opacity: 1;
  color: rgb(191 219 254 / var(--tw-text-opacity, 1));
}

.text-primary-700{
  --tw-text-opacity: 1;
  color: rgb(29 78 216 / var(--tw-text-opacity, 1));
}

.text-secondary{
  --tw-text-opacity: 1;
  color: rgb(59 130 246 / var(--tw-text-opacity, 1));
}

.text-success{
  --tw-text-opacity: 1;
  color: rgb(16 185 129 / var(--tw-text-opacity, 1));
}

.text-text-primary{
  --tw-text-opacity: 1;
  color: rgb(31 41 55 / var(--tw-text-opacity, 1));
}

.text-text-secondary{
  --tw-text-opacity: 1;
  color: rgb(107 114 128 / var(--tw-text-opacity, 1));
}

.text-warning{
  --tw-text-opacity: 1;
  color: rgb(245 158 11 / var(--tw-text-opacity, 1));
}

.text-white{
  --tw-text-opacity: 1;
  color: rgb(255 255 255 / var(--tw-text-opacity, 1));
}

.opacity-10{
  opacity: 0.1;
}

.opacity-50{
  opacity: 0.5;
}

.opacity-60{
  opacity: 0.6;
}

.opacity-75{
  opacity: 0.75;
}

.opacity-90{
  opacity: 0.9;
}

.shadow-2xl{
  --tw-shadow: 0 25px 50px -12px rgb(0 0 0 / 0.25);
  --tw-shadow-colored: 0 25px 50px -12px var(--tw-shadow-color);
  box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
}

.shadow-cta{
  --tw-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  --tw-shadow-colored: 0 4px 6px -1px var(--tw-shadow-color);
  box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
}

.shadow-lg{
  --tw-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
  --tw-shadow-colored: 0 10px 15px -3px var(--tw-shadow-color), 0 4px 6px -4px var(--tw-shadow-color);
  box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
}

.shadow-sm{
  --tw-shadow: 0 1px 2px 0 rgb(0 0 0 / 0.05);
  --tw-shadow-colored: 0 1px 2px 0 var(--tw-shadow-color);
  box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
}

.shadow-xl{
  --tw-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
  --tw-shadow-colored: 0 20px 25px -5px var(--tw-shadow-color), 0 8px 10px -6px var(--tw-shadow-color);
  box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
}

.backdrop-blur-sm{
  --tw-backdrop-blur: blur(4px);
  -webkit-backdrop-filter: var(--tw-backdrop-blur) var(--tw-backdrop-brightness) var(--tw-backdrop-contrast) var(--tw-backdrop-grayscale) var(--tw-backdrop-hue-rotate) var(--tw-backdrop-invert) var(--tw-backdrop-opacity) var(--tw-backdrop-saturate) var(--tw-backdrop-sepia);
  backdrop-filter: var(--tw-backdrop-blur) var(--tw-backdrop-brightness) var(--tw-backdrop-contrast) var(--tw-backdrop-grayscale) var(--tw-backdrop-hue-rotate) var(--tw-backdrop-invert) var(--tw-backdrop-opacity) var(--tw-backdrop-saturate) var(--tw-backdrop-sepia);
}

.transition-transform{
  transition-property: transform;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
  transition-duration: 150ms;
}

.duration-300{
  transition-duration: 300ms;
}

.ease-in-out{
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
}

.transition-standard {
  transition: all 250ms ease-in-out;
}

.shadow-cta {
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

:root {
  /* Primary Colors */
  --color-primary: #1e40af;
  /* blue-800 - Academic authority blue */
  --color-primary-50: #eff6ff;
  /* blue-50 */
  --color-primary-100: #dbeafe;
  /* blue-100 */
  --color-primary-200: #bfdbfe;
  /* blue-200 */
  --color-primary-300: #93c5fd;
  /* blue-300 */
  --color-primary-400: #60a5fa;
  /* blue-400 */
  --color-primary-500: #3b82f6;
  /* blue-500 */
  --color-primary-600: #2563eb;
  /* blue-600 */
  --color-primary-700: #1d4ed8;
  /* blue-700 */
  --color-primary-800: #1e40af;
  /* blue-800 */
  --color-primary-900: #1e3a8a;
  /* blue-900 */
  /* Secondary Colors */
  --color-secondary: #3b82f6;
  /* blue-500 - Supporting blue */
  --color-secondary-50: #eff6ff;
  /* blue-50 */
  --color-secondary-100: #dbeafe;
  /* blue-100 */
  --color-secondary-200: #bfdbfe;
  /* blue-200 */
  --color-secondary-300: #93c5fd;
  /* blue-300 */
  --color-secondary-400: #60a5fa;
  /* blue-400 */
  --color-secondary-500: #3b82f6;
  /* blue-500 */
  --color-secondary-600: #2563eb;
  /* blue-600 */
  --color-secondary-700: #1d4ed8;
  /* blue-700 */
  --color-secondary-800: #1e40af;
  /* blue-800 */
  --color-secondary-900: #1e3a8a;
  /* blue-900 */
  /* Accent Colors */
  --color-accent: #f97316;
  /* orange-500 - Conversion orange */
  --color-accent-50: #fff7ed;
  /* orange-50 */
  --color-accent-100: #ffedd5;
  /* orange-100 */
  --color-accent-200: #fed7aa;
  /* orange-200 */
  --color-accent-300: #fdba74;
  /* orange-300 */
  --color-accent-400: #fb923c;
  /* orange-400 */
  --color-accent-500: #f97316;
  /* orange-500 */
  --color-accent-600: #ea580c;
  /* orange-600 */
  --color-accent-700: #c2410c;
  /* orange-700 */
  --color-accent-800: #9a3412;
  /* orange-800 */
  --color-accent-900: #7c2d12;
  /* orange-900 */
  /* Background Colors */
  --color-background: #ffffff;
  /* white */
  --color-surface: #f8fafc;
  /* slate-50 */
  /* Text Colors */
  --color-text-primary: #1f2937;
  /* gray-800 */
  --color-text-secondary: #6b7280;
  /* gray-500 */
  /* Status Colors */
  --color-success: #10b981;
  /* emerald-500 */
  --color-success-50: #ecfdf5;
  /* emerald-50 */
  --color-success-100: #d1fae5;
  /* emerald-100 */
  --color-success-500: #10b981;
  /* emerald-500 */
  --color-success-600: #059669;
  /* emerald-600 */
  --color-warning: #f59e0b;
  /* amber-500 */
  --color-warning-50: #fffbeb;
  /* amber-50 */
  --color-warning-100: #fef3c7;
  /* amber-100 */
  --color-warning-500: #f59e0b;
  /* amber-500 */
  --color-warning-600: #d97706;
  /* amber-600 */
  --color-error: #ef4444;
  /* red-500 */
  --color-error-50: #fef2f2;
  /* red-50 */
  --color-error-100: #fee2e2;
  /* red-100 */
  --color-error-500: #ef4444;
  /* red-500 */
  --color-error-600: #dc2626;
  /* red-600 */
  /* Border Colors */
  --color-border: #e5e7eb;
  /* gray-200 */
  --color-border-light: #f3f4f6;
  /* gray-100 */
}

/* Custom Components */

/* Custom Utilities */

.hover\:border-primary-400:hover{
  --tw-border-opacity: 1;
  border-color: rgb(96 165 250 / var(--tw-border-opacity, 1));
}

.hover\:bg-accent-600:hover{
  --tw-bg-opacity: 1;
  background-color: rgb(234 88 12 / var(--tw-bg-opacity, 1));
}

.hover\:bg-gray-100:hover{
  --tw-bg-opacity: 1;
  background-color: rgb(243 244 246 / var(--tw-bg-opacity, 1));
}

.hover\:bg-primary-50:hover{
  --tw-bg-opacity: 1;
  background-color: rgb(239 246 255 / var(--tw-bg-opacity, 1));
}

.hover\:bg-secondary-600:hover{
  --tw-bg-opacity: 1;
  background-color: rgb(37 99 235 / var(--tw-bg-opacity, 1));
}

.hover\:bg-opacity-30:hover{
  --tw-bg-opacity: 0.3;
}

.hover\:text-accent-600:hover{
  --tw-text-opacity: 1;
  color: rgb(234 88 12 / var(--tw-text-opacity, 1));
}

.hover\:text-primary:hover{
  --tw-text-opacity: 1;
  color: rgb(30 64 175 / var(--tw-text-opacity, 1));
}

.hover\:text-primary-600:hover{
  --tw-text-opacity: 1;
  color: rgb(37 99 235 / var(--tw-text-opacity, 1));
}

.hover\:text-success-600:hover{
  --tw-text-opacity: 1;
  color: rgb(5 150 105 / var(--tw-text-opacity, 1));
}

.hover\:text-white:hover{
  --tw-text-opacity: 1;
  color: rgb(255 255 255 / var(--tw-text-opacity, 1));
}

.hover\:underline:hover{
  text-decoration-line: underline;
}

.hover\:shadow-md:hover{
  --tw-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
  --tw-shadow-colored: 0 4px 6px -1px var(--tw-shadow-color), 0 2px 4px -2px var(--tw-shadow-color);
  box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
}

.hover\:shadow-xl:hover{
  --tw-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
  --tw-shadow-colored: 0 20px 25px -5px var(--tw-shadow-color), 0 8px 10px -6px var(--tw-shadow-color);
  box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
}

.group:hover .group-hover\:bg-accent-200{
  --tw-bg-opacity: 1;
  background-color: rgb(254 215 170 / var(--tw-bg-opacity, 1));
}

.group:hover .group-hover\:bg-primary-200{
  --tw-bg-opacity: 1;
  background-color: rgb(191 219 254 / var(--tw-bg-opacity, 1));
}

.group:hover .group-hover\:bg-secondary-200{
  --tw-bg-opacity: 1;
  background-color: rgb(191 219 254 / var(--tw-bg-opacity, 1));
}

@media (min-width: 640px){
  .sm\:flex-row{
    flex-direction: row;
  }

  .sm\:px-6{
    padding-left: 1.5rem;
    padding-right: 1.5rem;
  }
}

@media (min-width: 768px){
  .md\:mt-0{
    margin-top: 0px;
  }

  .md\:flex{
    display: flex;
  }

  .md\:hidden{
    display: none;
  }

  .md\:grid-cols-2{
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }

  .md\:grid-cols-3{
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }

  .md\:grid-cols-4{
    grid-template-columns: repeat(4, minmax(0, 1fr));
  }

  .md\:flex-row{
    flex-direction: row;
  }
}

@media (min-width: 1024px){
  .lg\:col-span-2{
    grid-column: span 2 / span 2;
  }

  .lg\:grid-cols-2{
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }

  .lg\:grid-cols-3{
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }

  .lg\:grid-cols-4{
    grid-template-columns: repeat(4, minmax(0, 1fr));
  }

  .lg\:grid-cols-6{
    grid-template-columns: repeat(6, minmax(0, 1fr));
  }

  .lg\:justify-start{
    justify-content: flex-start;
  }

  .lg\:px-8{
    padding-left: 2rem;
    padding-right: 2rem;
  }

  .lg\:text-left{
    text-align: left;
  }

  .lg\:text-4xl{
    font-size: 2.25rem;
    line-height: 2.5rem;
  }

  .lg\:text-5xl{
    font-size: 3rem;
    line-height: 1;
  }

  .lg\:text-6xl{
    font-size: 3.75rem;
    line-height: 1;
  }
}

 .dropdown-menu {
            position: absolute;
            top: 100%;
            right: 0;
            margin-top: 0.5rem;
            width: 200px;
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: all 0.2s ease-in-out;
        }

        .dropdown-menu.show {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .dropdown-item {
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            color: #374151;
            text-decoration: none;
            transition: background-color 0.2s;
            border: none;
            background: none;
            width: 100%;
            text-align: left;
            cursor: pointer;
        }

        .dropdown-item:hover {
            background-color: #f9fafb;
        }

        .dropdown-item svg {
            width: 1rem;
            height: 1rem;
            margin-right: 0.75rem;
            color: #6b7280;
        }

        .dropdown-divider {
            height: 1px;
            background-color: #e5e7eb;
            margin: 0.25rem 0;
        }

        .relative {
            position: relative;
        }
    </style>
</head>
<body class="font-inter bg-background text-text-primary">
    <%
        // Datos del docente (simulados - en una aplicación real vendrían de la base de datos)
        String nombreDocente = "Dr. Roberto Silva";
        String rolDocente = "Revisor Principal";
        String fotoPerfil = "https://images.unsplash.com/photo-1659353887488-b3c443982a57";
        
        // Estadísticas del docente
        int tesisAsignadas = 5;
        int tesisPendientes = 2;
        int tesisEnRevision = 2;
        int tesisCompletadas = 1;
        int tesisRevisadasMes = 12;
        double tiempoPromedio = 5.2;
        double calificacionEstudiantes = 4.8;
        int tasaAprobacion = 92;
    %>

    <!-- Navigation Header -->
    <nav class="bg-white border-b border-gray-200 sticky top-0 z-50 shadow-sm">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <!-- Logo -->
                <div class="flex items-center">
                    <svg class="h-8 w-8 text-primary" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M12 2L2 7v10c0 5.55 3.84 9.74 9 11 5.16-1.26 9-5.45 9-11V7l-10-5z"/>
                        <path d="M9 12l2 2 4-4" stroke="white" stroke-width="2" fill="none"/>
                    </svg>
                    <span class="ml-2 text-xl font-bold text-primary">ThesisReview</span>
                    <span class="ml-3 px-2 py-1 bg-accent-100 text-accent text-xs font-medium rounded-full">Docente</span>
                </div>

                <!-- Navigation Tabs -->
                <div class="hidden md:flex items-center space-x-1">
                    <button class="px-4 py-2 text-sm font-medium text-primary bg-primary-50 rounded-lg" id="reviewsTab">
                        Revisiones
                    </button>
                    <button class="px-4 py-2 text-sm font-medium text-text-secondary hover:text-primary transition-standard" id="calendarTab">
                        Calendario
                    </button>
                    <button class="px-4 py-2 text-sm font-medium text-text-secondary hover:text-primary transition-standard" id="analyticsTab">
                        Estadísticas
                    </button>
                </div>

<!-- User Profile -->
                <div class="flex items-center space-x-4">
                    <!-- Notifications -->
                    <button class="p-2 text-text-secondary hover:text-primary transition-standard relative">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-5 5v-5zM4 17h5l-5 5v-5zM12 12l8-8m0 0l-8 8m8-8v8"/>
                        </svg>
                        <span class="absolute -top-1 -right-1 bg-accent text-white text-xs w-5 h-5 rounded-full flex items-center justify-center">3</span>
                    </button>

                    <!-- User Menu -->
                    <div class="relative">
                        <div class="flex items-center space-x-3 cursor-pointer" id="user-menu-button">
                            <div class="text-right">
                                <div class="text-sm font-medium text-primary">María González</div>
                                <div class="text-xs text-text-secondary">Ingeniería Industrial</div>
                            </div>
                            <img src="https://img.rocket.new/generatedImages/rocket_gen_img_1037a390f-1762273998500.png" 
                                 alt="Foto de perfil de María González" 
                                 class="w-10 h-10 rounded-full object-cover border-2 border-secondary-200"
                                 onerror="this.src='https://images.unsplash.com/photo-1584824486509-112e4181ff6b?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'; this.onerror=null;">
                            <button class="p-1 hover:bg-gray-100 rounded-full">
                                <svg class="w-4 h-4 text-text-secondary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                                </svg>
                            </button>
                        </div>

                        <!-- Dropdown Menu -->
                        <div class="dropdown-menu" id="user-dropdown">
                            <div class="p-2">
                                <button class="dropdown-item">
                                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                                    </svg>
                                    Mi Perfil
                                </button>
                                <button class="dropdown-item">
                                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                    </svg>
                                    Configuración
                                </button>
                                <button class="dropdown-item">
                                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192L5.636 18.364M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                    </svg>
                                    Ayuda y Soporte
                                </button>
                            </div>
                            <div class="dropdown-divider"></div>
                            <div class="p-2">
                                <button class="dropdown-item text-error" id="logout-button">
                                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                                    </svg>
                                    Cerrar Sesión
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Welcome Header -->
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-primary mb-2">¡Bienvenido, <%= nombreDocente %>!</h1>
            <p class="text-text-secondary">Gestiona tus revisiones asignadas y proporciona retroalimentación académica de calidad.</p>
        </div>

        <!-- Quick Stats -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                <div class="flex items-center">
                    <div class="w-12 h-12 bg-accent-100 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-accent" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                        </svg>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm text-text-secondary">Tesis Asignadas</p>
                        <p class="text-2xl font-bold text-accent"><%= tesisAsignadas %></p>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                <div class="flex items-center">
                    <div class="w-12 h-12 bg-warning-100 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-warning" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm text-text-secondary">Pendientes</p>
                        <p class="text-2xl font-bold text-warning"><%= tesisPendientes %></p>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                <div class="flex items-center">
                    <div class="w-12 h-12 bg-primary-100 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                        </svg>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm text-text-secondary">En Revisión</p>
                        <p class="text-2xl font-bold text-primary"><%= tesisEnRevision %></p>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                <div class="flex items-center">
                    <div class="w-12 h-12 bg-success-100 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-success" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm text-text-secondary">Completadas</p>
                        <p class="text-2xl font-bold text-success"><%= tesisCompletadas %></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Dashboard Grid -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Left Column - Thesis Queue -->
            <div class="lg:col-span-2 space-y-8">
                <!-- Filter Bar -->
                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                    <div class="flex flex-col md:flex-row gap-4 items-center justify-between">
                        <div class="flex gap-3 flex-1">
                            <select class="form-input text-sm">
                                <option>Todas las tesis</option>
                                <option>Pendientes</option>
                                <option>En revisión</option>
                                <option>Completadas</option>
                            </select>
                            <select class="form-input text-sm">
                                <option>Todas las carreras</option>
                                <option>Ingeniería</option>
                                <option>Medicina</option>
                                <option>Psicología</option>
                            </select>
                            <select class="form-input text-sm">
                                <option>Ordenar por fecha</option>
                                <option>Por prioridad</option>
                                <option>Por estudiante</option>
                            </select>
                        </div>
                        <div class="flex gap-2">
                            <button class="p-2 text-text-secondary hover:text-primary transition-standard" title="Vista Lista">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 10h16M4 14h16M4 18h16"/>
                                </svg>
                            </button>
                            <button class="p-2 text-primary bg-primary-50 rounded transition-standard" title="Vista Tarjetas">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"/>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Thesis Queue -->
                <div class="space-y-6">
                    <!-- High Priority Thesis -->
                    <div class="bg-white rounded-xl border-l-4 border-error border-r border-t border-b border-gray-200 shadow-sm overflow-hidden hover:shadow-md transition-standard">
                        <div class="p-6">
                            <div class="flex items-start justify-between mb-4">
                                <div class="flex items-center space-x-3">
                                    <img src="https://img.rocket.new/generatedImages/rocket_gen_img_1beb9fc75-1762273370028.png" 
                                         alt="María González" 
                                         class="w-12 h-12 rounded-full object-cover"
                                         onerror="this.src='https://images.unsplash.com/photo-1584824486509-112e4181ff6b?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'; this.onerror=null;">
                                    <div>
                                        <h3 class="text-lg font-semibold text-primary">María González Ruiz</h3>
                                        <p class="text-sm text-text-secondary">Ingeniería Industrial • ID: #TH-2025-001</p>
                                    </div>
                                </div>
                                <div class="flex flex-col items-end space-y-2">
                                    <span class="bg-error text-white text-xs px-3 py-1 rounded-full font-medium">URGENTE</span>
                                    <span class="text-xs text-text-secondary">Vence en 2 días</span>
                                </div>
                            </div>

                            <div class="mb-4">
                                <h4 class="font-medium text-gray-900 mb-2">Optimización de Procesos en Sistemas de Manufactura</h4>
                                <p class="text-sm text-text-secondary line-clamp-2">
                                    Análisis y optimización de procesos de manufactura utilizando metodologías Lean Six Sigma para mejorar la eficiencia operacional en empresas del sector automotriz.
                                </p>
                            </div>

                            <div class="flex items-center justify-between mb-4">
                                <div class="flex items-center space-x-4 text-sm text-text-secondary">
                                    <span class="flex items-center">
                                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                        </svg>
                                        156 páginas
                                    </span>
                                    <span class="flex items-center">
                                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"/>
                                        </svg>
                                        Subido: 02 Nov 2025
                                    </span>
                                </div>
                                <div class="flex items-center text-sm">
                                    <span class="text-primary">Progreso: 65%</span>
                                    <div class="w-20 bg-gray-200 rounded-full h-2 ml-2">
                                        <div class="bg-primary h-2 rounded-full" style="width: 65%"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="flex gap-3">
                                <button class="btn-primary flex-1" onclick="openThesisViewer('TH-2025-001')">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                    </svg>
                                    Revisar
                                </button>
                                <button class="btn-secondary" onclick="sendMessage('maria.gonzalez@universidad.es')">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
                                    </svg>
                                    Mensaje
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Normal Priority Thesis -->
                    <div class="bg-white rounded-xl border-l-4 border-warning border-r border-t border-b border-gray-200 shadow-sm overflow-hidden hover:shadow-md transition-standard">
                        <div class="p-6">
                            <div class="flex items-start justify-between mb-4">
                                <div class="flex items-center space-x-3">
                                    <img src="https://img.rocket.new/generatedImages/rocket_gen_img_111874aba-1762274570522.png" 
                                         alt="Carlos Ruiz" 
                                         class="w-12 h-12 rounded-full object-cover"
                                         onerror="this.src='https://images.unsplash.com/photo-1584824486509-112e4181ff6b?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'; this.onerror=null;">
                                    <div>
                                        <h3 class="text-lg font-semibold text-primary">Carlos Ruiz Méndez</h3>
                                        <p class="text-sm text-text-secondary">Medicina • ID: #TH-2025-002</p>
                                    </div>
                                </div>
                                <div class="flex flex-col items-end space-y-2">
                                    <span class="bg-warning text-white text-xs px-3 py-1 rounded-full font-medium">MEDIA</span>
                                    <span class="text-xs text-text-secondary">Vence en 8 días</span>
                                </div>
                            </div>

                            <div class="mb-4">
                                <h4 class="font-medium text-gray-900 mb-2">Efectos de la Telemedicina en Pacientes Rurales</h4>
                                <p class="text-sm text-text-secondary line-clamp-2">
                                    Estudio longitudinal sobre la efectividad de programas de telemedicina en comunidades rurales y su impacto en los resultados de salud cardiovascular.
                                </p>
                            </div>

                            <div class="flex items-center justify-between mb-4">
                                <div class="flex items-center space-x-4 text-sm text-text-secondary">
                                    <span class="flex items-center">
                                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                        </svg>
                                        203 páginas
                                    </span>
                                    <span class="flex items-center">
                                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"/>
                                        </svg>
                                        Subido: 28 Oct 2025
                                    </span>
                                </div>
                                <div class="flex items-center text-sm">
                                    <span class="text-warning">Progreso: 30%</span>
                                    <div class="w-20 bg-gray-200 rounded-full h-2 ml-2">
                                        <div class="bg-warning h-2 rounded-full" style="width: 30%"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="flex gap-3">
                                <button class="btn-primary flex-1" onclick="openThesisViewer('TH-2025-002')">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                    </svg>
                                    Revisar
                                </button>
                                <button class="btn-secondary" onclick="sendMessage('carlos.ruiz@universidad.es')">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
                                    </svg>
                                    Mensaje
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Low Priority Thesis -->
                    <div class="bg-white rounded-xl border-l-4 border-success border-r border-t border-b border-gray-200 shadow-sm overflow-hidden hover:shadow-md transition-standard">
                        <div class="p-6">
                            <div class="flex items-start justify-between mb-4">
                                <div class="flex items-center space-x-3">
                                    <img src="https://img.rocket.new/generatedImages/rocket_gen_img_1711e0d8f-1762273338115.png" 
                                         alt="Ana Martínez" 
                                         class="w-12 h-12 rounded-full object-cover"
                                         onerror="this.src='https://images.unsplash.com/photo-1584824486509-112e4181ff6b?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'; this.onerror=null;">
                                    <div>
                                        <h3 class="text-lg font-semibold text-primary">Ana Martínez López</h3>
                                        <p class="text-sm text-text-secondary">Psicología • ID: #TH-2025-003</p>
                                    </div>
                                </div>
                                <div class="flex flex-col items-end space-y-2">
                                    <span class="bg-success text-white text-xs px-3 py-1 rounded-full font-medium">COMPLETADO</span>
                                    <span class="text-xs text-text-secondary">Revisado</span>
                                </div>
                            </div>

                            <div class="mb-4">
                                <h4 class="font-medium text-gray-900 mb-2">Impacto de la Terapia Digital en Ansiedad</h4>
                                <p class="text-sm text-text-secondary line-clamp-2">
                                    Evaluación de la efectividad de aplicaciones móviles de terapia cognitivo-conductual en el tratamiento de trastornos de ansiedad generalizada.
                                </p>
                            </div>

                            <div class="flex items-center justify-between mb-4">
                                <div class="flex items-center space-x-4 text-sm text-text-secondary">
                                    <span class="flex items-center">
                                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                        </svg>
                                        189 páginas
                                    </span>
                                    <span class="flex items-center">
                                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                        </svg>
                                        Aprobado: 05 Nov 2025
                                    </span>
                                </div>
                                <div class="flex items-center text-sm">
                                    <span class="text-success">Progreso: 100%</span>
                                    <div class="w-20 bg-gray-200 rounded-full h-2 ml-2">
                                        <div class="bg-success h-2 rounded-full" style="width: 100%"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="flex gap-3">
                                <button class="btn-accent flex-1" onclick="viewCompletedThesis('TH-2025-003')">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                    </svg>
                                    Ver Evaluación
                                </button>
                                <button class="btn-secondary" onclick="generateCertificate('TH-2025-003')">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                    </svg>
                                    Certificado
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column - Tools & Analytics -->
            <div class="space-y-8">
                <!-- Review Tools -->
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
                    <div class="px-6 py-4 border-b border-gray-200 bg-accent-50">
                        <h2 class="text-lg font-semibold text-primary flex items-center">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                            </svg>
                            Herramientas de Evaluación
                        </h2>
                    </div>
                    <div class="p-6">
                        <div class="space-y-4">
                            <button class="w-full btn-primary text-left flex items-center justify-between" onclick="openRubricTemplate()">
                                <span class="flex items-center">
                                    <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"/>
                                    </svg>
                                    Plantilla de Rúbrica
                                </span>
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                            </button>

                            <button class="w-full btn-secondary text-left flex items-center justify-between" onclick="openAnnotationTool()">
                                <span class="flex items-center">
                                    <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/>
                                    </svg>
                                    Herramientas de Anotación
                                </span>
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                            </button>

                            <button class="w-full btn-accent text-left flex items-center justify-between" onclick="openFeedbackForm()">
                                <span class="flex items-center">
                                    <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"/>
                                    </svg>
                                    Formulario de Retroalimentación
                                </span>
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Performance Analytics -->
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
                    <div class="px-6 py-4 border-b border-gray-200 bg-primary-50">
                        <h2 class="text-lg font-semibold text-primary flex items-center">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                            </svg>
                            Mi Rendimiento
                        </h2>
                    </div>
                    <div class="p-6">
                        <div class="space-y-6">
                            <!-- Monthly Stats -->
                            <div class="text-center">
                                <div class="text-3xl font-bold text-primary mb-1"><%= tesisRevisadasMes %></div>
                                <div class="text-sm text-text-secondary">Tesis revisadas este mes</div>
                            </div>

                            <!-- Performance Metrics -->
                            <div class="space-y-4">
                                <div class="flex items-center justify-between">
                                    <span class="text-sm text-text-secondary">Tiempo Promedio</span>
                                    <span class="text-sm font-medium text-primary"><%= tiempoPromedio %> días</span>
                                </div>
                                <div class="flex items-center justify-between">
                                    <span class="text-sm text-text-secondary">Calificación de Estudiantes</span>
                                    <div class="flex items-center space-x-1">
                                        <span class="text-sm font-medium text-accent"><%= calificacionEstudiantes %></span>
                                        <div class="flex">
                                            <% for(int i = 0; i < 5; i++) { %>
                                                <svg class="w-4 h-4 text-accent" fill="currentColor" viewBox="0 0 20 20">
                                                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                                                </svg>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                                <div class="flex items-center justify-between">
                                    <span class="text-sm text-text-secondary">Tasa de Aprobación</span>
                                    <span class="text-sm font-medium text-success"><%= tasaAprobacion %>%</span>
                                </div>
                            </div>

                            <!-- Progress Chart (Simplified) -->
                            <div class="pt-4 border-t border-gray-200">
                                <div class="text-xs text-text-secondary mb-2">Carga de trabajo semanal</div>
                                <div class="flex items-end space-x-1 h-16">
                                    <div class="bg-primary-200 w-4 h-8 rounded-sm"></div>
                                    <div class="bg-primary-300 w-4 h-12 rounded-sm"></div>
                                    <div class="bg-primary-400 w-4 h-16 rounded-sm"></div>
                                    <div class="bg-primary-500 w-4 h-10 rounded-sm"></div>
                                    <div class="bg-primary-600 w-4 h-14 rounded-sm"></div>
                                    <div class="bg-primary w-4 h-12 rounded-sm"></div>
                                    <div class="bg-primary-400 w-4 h-8 rounded-sm"></div>
                                </div>
                                <div class="flex justify-between text-xs text-text-secondary mt-1">
                                    <span>Lun</span>
                                    <span>Vie</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="bg-gradient-to-br from-secondary to-accent text-white rounded-xl p-6 shadow-sm">
                    <h3 class="text-lg font-semibold mb-4">Acciones Rápidas</h3>
                    <div class="space-y-3">
                        <button class="w-full bg-white bg-opacity-20 hover:bg-opacity-30 backdrop-blur-sm rounded-lg p-3 text-left transition-standard">
                            <div class="flex items-center">
                                <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3a2 2 0 012-2h4a2 2 0 012 2v4m-6 0V6a2 2 0 012-2h4a2 2 0 012 2v1m-6 0h6m-6 0l-.5 8.5A2 2 0 0011 18h2a2 2 0 002-1.5L14.5 7"/>
                                </svg>
                                <span class="text-sm font-medium">Generar Reporte Mensual</span>
                            </div>
                        </button>
                        
                        <button class="w-full bg-white bg-opacity-20 hover:bg-opacity-30 backdrop-blur-sm rounded-lg p-3 text-left transition-standard">
                            <div class="flex items-center">
                                <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"/>
                                </svg>
                                <span class="text-sm font-medium">Sincronizar Calendario</span>
                            </div>
                        </button>
                        
                        <button class="w-full bg-white bg-opacity-20 hover:bg-opacity-30 backdrop-blur-sm rounded-lg p-3 text-left transition-standard">
                            <div class="flex items-center">
                                <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                                </svg>
                                <span class="text-sm font-medium">Exportar Plantillas</span>
                            </div>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script>
        // Tab Management
        function switchTab(tabName) {
            // Remove active class from all tabs
            document.querySelectorAll('[id$="Tab"]').forEach(tab => {
                tab.classList.remove('text-primary', 'bg-primary-50');
                tab.classList.add('text-text-secondary');
            });
            
            // Add active class to clicked tab
            document.getElementById(tabName + 'Tab').classList.remove('text-text-secondary');
            document.getElementById(tabName + 'Tab').classList.add('text-primary', 'bg-primary-50');
            
            showNotification(`Cambiando a vista de ${tabName}`, 'info');
        }

        // Thesis Review Functions
        function openThesisViewer(thesisId) {
            showNotification(`Abriendo revisor de tesis ${thesisId}...`, 'info');
            // This would typically open a detailed thesis review interface
        }

        function sendMessage(studentEmail) {
            showNotification(`Abriendo chat con ${studentEmail}`, 'info');
            // This would typically open a messaging interface
        }

        function viewCompletedThesis(thesisId) {
            showNotification(`Visualizando evaluación completa de ${thesisId}`, 'success');
            // This would typically show the completed evaluation
        }

        function generateCertificate(thesisId) {
            showNotification(`Generando certificado para ${thesisId}...`, 'info');
            // This would typically generate and download a certificate
        }

        // Evaluation Tools
        function openRubricTemplate() {
            showNotification('Abriendo plantilla de rúbrica...', 'info');
            // This would typically open rubric creation/editing interface
        }

        function openAnnotationTool() {
            showNotification('Iniciando herramientas de anotación...', 'info');
            // This would typically open PDF annotation tools
        }

        function openFeedbackForm() {
            showNotification('Cargando formulario de retroalimentación...', 'info');
            // This would typically open structured feedback forms
        }
        
        // Dropdown Menu Functionality
        document.addEventListener('DOMContentLoaded', function() {
            const userMenuButton = document.getElementById('user-menu-button');
            const userDropdown = document.getElementById('user-dropdown');
            const logoutButton = document.getElementById('logout-button');

            // Toggle dropdown menu
            userMenuButton.addEventListener('click', function(e) {
                e.stopPropagation();
                userDropdown.classList.toggle('show');
            });

            // Close dropdown when clicking outside
            document.addEventListener('click', function(e) {
                if (!userMenuButton.contains(e.target) && !userDropdown.contains(e.target)) {
                    userDropdown.classList.remove('show');
                }
            });

            // Logout functionality
            logoutButton.addEventListener('click', function() {
                if (confirm('¿Estás seguro de que deseas cerrar sesión?')) {
                    showNotification('Cerrando sesión...', 'info');
                    // Simulate logout process
                    setTimeout(() => {
                        window.location.href = 'index.jsp';
                    }, 1500);
                }
            });

            // Prevent dropdown from closing when clicking inside it
            userDropdown.addEventListener('click', function(e) {
                e.stopPropagation();
            });

            // Show welcome message
            setTimeout(() => {
                showNotification('¡Bienvenida de vuelta, María! Tienes 3 comentarios nuevos.', 'info');
            }, 1000);
        });


        // Notification system
        function showNotification(message, type = 'info') {
            const notification = document.createElement('div');
            notification.className = `fixed top-4 right-4 z-50 max-w-sm w-full bg-white border border-gray-200 rounded-lg shadow-lg p-4 transform translate-x-full transition-transform duration-300 ease-in-out`;
            
            const iconColor = type === 'success' ? 'text-success' : type === 'error' ? 'text-error' : 'text-primary';
            const icon = type === 'success' ? 'M5 13l4 4L19 7' : type === 'error' ? 'M6 18L18 6M6 6l12 12' : 'M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z';
            
            notification.innerHTML = `
                <div class="flex items-center">
                    <svg class="w-5 h-5 ${iconColor} mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="${icon}"/>
                    </svg>
                    <p class="text-sm text-text-primary">${message}</p>
                </div>
            `;
            
            document.body.appendChild(notification);
            
            // Animate in
            setTimeout(() => {
                notification.classList.remove('translate-x-full');
            }, 100);
            
            // Auto remove after 5 seconds
            setTimeout(() => {
                notification.classList.add('translate-x-full');
                setTimeout(() => {
                    document.body.removeChild(notification);
                }, 300);
            }, 5000);
        }

        // Tab event listeners
        document.getElementById('reviewsTab').addEventListener('click', () => switchTab('reviews'));
        document.getElementById('calendarTab').addEventListener('click', () => switchTab('calendar'));
        document.getElementById('analyticsTab').addEventListener('click', () => switchTab('analytics'));

        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            // Show welcome message
            setTimeout(() => {
                showNotification('¡Bienvenido de vuelta, Dr. Silva! Tienes 2 tesis urgentes pendientes.', 'info');
            }, 1000);
        });
    </script>
</body>
</html>