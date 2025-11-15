<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Administrador - ThesisReview Portal</title>
    <meta name="description" content="Panel de control del administrador para gestión integral de usuarios, tesis y asignaciones en ThesisReview Portal">
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
    </style>
</head>
<body class="font-inter bg-background text-text-primary min-h-screen">
    <%
        // Datos del administrador (simulados - en una aplicación real vendrían de la base de datos)
        String nombreAdmin = "Admin García";
        
        // Estadísticas del sistema
        int estudiantesActivos = 245;
        int docentesEvaluadores = 18;
        int tesisTotales = 67;
        int tesisSinAsignar = 12;
        int tesisCompletadasPorcentaje = 78;
        int cargaDocentesPorcentaje = 85;
        int eficienciaPorcentaje = 92;
    %>

    <!-- Navigation Header -->
    <nav class="bg-white border-b border-gray-200 sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <!-- Logo -->
                <div class="flex items-center">
                    <svg class="h-8 w-8 text-primary" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M12 2L2 7v10c0 5.55 3.84 9.74 9 11 5.16-1.26 9-5.45 9-11V7l-10-5z"/>
                        <path d="M9 12l2 2 4-4" stroke="white" stroke-width="2" fill="none"/>
                    </svg>
                    <span class="ml-2 text-xl font-bold text-primary">ThesisReview</span>
                    <span class="ml-3 px-2 py-1 bg-primary-100 text-primary text-xs rounded-full">Administrador</span>
                </div>
                
                <!-- Navigation Links -->
                <div class="hidden md:flex items-center space-x-8">
                    <a href="#dashboard" class="text-primary font-medium">Dashboard</a>
                    <a href="#users" class="text-text-secondary hover:text-primary transition-standard">Usuarios</a>
                    <a href="#thesis" class="text-text-secondary hover:text-primary transition-standard">Tesis</a>
                    <a href="#assignments" class="text-text-secondary hover:text-primary transition-standard">Asignaciones</a>
                    <a href="#reports" class="text-text-secondary hover:text-primary transition-standard">Reportes</a>
                </div>

                <!-- User Menu -->
                <div class="flex items-center space-x-4">
                    <div class="flex items-center space-x-2">
                        <div class="w-8 h-8 bg-primary rounded-full flex items-center justify-center">
                            <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                            </svg>
                        </div>
                        <span class="text-sm font-medium"><%= nombreAdmin %></span>
                    </div>
                    <button class="text-text-secondary hover:text-primary transition-standard" onclick="logout()">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                        </svg>
                    </button>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Dashboard -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Dashboard Header -->
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-primary mb-2">Panel de Administrador</h1>
            <p class="text-text-secondary">Gestión integral del ecosistema de tesis académicas</p>
        </div>

        <!-- Statistics Cards -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <!-- Total Students -->
            <div class="bg-white rounded-lg border border-gray-200 p-6">
                <div class="flex items-center">
                    <div class="w-12 h-12 bg-secondary-100 rounded-lg flex items-center justify-center mr-4">
                        <svg class="w-6 h-6 text-secondary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"/>
                        </svg>
                    </div>
                    <div>
                        <p class="text-2xl font-bold text-primary"><%= estudiantesActivos %></p>
                        <p class="text-sm text-text-secondary">Estudiantes Activos</p>
                    </div>
                </div>
            </div>

            <!-- Total Teachers -->
            <div class="bg-white rounded-lg border border-gray-200 p-6">
                <div class="flex items-center">
                    <div class="w-12 h-12 bg-accent-100 rounded-lg flex items-center justify-center mr-4">
                        <svg class="w-6 h-6 text-accent" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z"/>
                        </svg>
                    </div>
                    <div>
                        <p class="text-2xl font-bold text-primary"><%= docentesEvaluadores %></p>
                        <p class="text-sm text-text-secondary">Docentes Evaluadores</p>
                    </div>
                </div>
            </div>

            <!-- Total Thesis -->
            <div class="bg-white rounded-lg border border-gray-200 p-6">
                <div class="flex items-center">
                    <div class="w-12 h-12 bg-primary-100 rounded-lg flex items-center justify-center mr-4">
                        <svg class="w-6 h-6 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                    </div>
                    <div>
                        <p class="text-2xl font-bold text-primary"><%= tesisTotales %></p>
                        <p class="text-sm text-text-secondary">Tesis Totales</p>
                    </div>
                </div>
            </div>

            <!-- Pending Assignments -->
            <div class="bg-white rounded-lg border border-gray-200 p-6">
                <div class="flex items-center">
                    <div class="w-12 h-12 bg-warning-100 rounded-lg flex items-center justify-center mr-4">
                        <svg class="w-6 h-6 text-warning" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <div>
                        <p class="text-2xl font-bold text-primary"><%= tesisSinAsignar %></p>
                        <p class="text-sm text-text-secondary">Sin Asignar</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content Sections -->
        <div class="grid lg:grid-cols-3 gap-8">
            <!-- User Management Section -->
            <div class="lg:col-span-2 space-y-6">
                <!-- User Management -->
                <div class="bg-white rounded-lg border border-gray-200 p-6">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-xl font-semibold text-primary">Gestión de Usuarios</h2>
                        <div class="flex space-x-2">
                            <button class="btn-secondary text-sm px-3 py-2" onclick="showCreateUserModal('student')">
                                + Estudiante
                            </button>
                            <button class="btn-accent text-sm px-3 py-2" onclick="showCreateUserModal('teacher')">
                                + Docente
                            </button>
                        </div>
                    </div>

                    <!-- User Tabs -->
                    <div class="border-b border-gray-200 mb-6">
                        <nav class="-mb-px flex space-x-8">
                            <button class="py-2 px-1 border-b-2 border-primary text-primary font-medium text-sm" id="studentsTab" onclick="showUserTab('students')">
                                Estudiantes (<%= estudiantesActivos %>)
                            </button>
                            <button class="py-2 px-1 border-b-2 border-transparent text-text-secondary hover:text-primary text-sm" id="teachersTab" onclick="showUserTab('teachers')">
                                Docentes (<%= docentesEvaluadores %>)
                            </button>
                        </nav>
                    </div>

                    <!-- Students Table -->
                    <div id="studentsTable" class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Usuario</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Carrera</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Estado</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Tesis</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Acciones</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-10 w-10">
                                                <div class="h-10 w-10 rounded-full bg-secondary-100 flex items-center justify-center">
                                                    <span class="text-sm font-medium text-secondary">MG</span>
                                                </div>
                                            </div>
                                            <div class="ml-4">
                                                <div class="text-sm font-medium text-gray-900">María González</div>
                                                <div class="text-sm text-gray-500">maria.gonzalez@universidad.es</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Ingeniería Industrial</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-success-100 text-success">
                                            Activo
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">En Revisión</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <button class="text-primary hover:text-primary-600">Ver Detalles</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-10 w-10">
                                                <div class="h-10 w-10 rounded-full bg-secondary-100 flex items-center justify-center">
                                                    <span class="text-sm font-medium text-secondary">CR</span>
                                                </div>
                                            </div>
                                            <div class="ml-4">
                                                <div class="text-sm font-medium text-gray-900">Carlos Ruiz</div>
                                                <div class="text-sm text-gray-500">carlos.ruiz@universidad.es</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Medicina</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-success-100 text-success">
                                            Activo
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Aprobada</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <button class="text-primary hover:text-primary-600">Ver Detalles</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-10 w-10">
                                                <div class="h-10 w-10 rounded-full bg-secondary-100 flex items-center justify-center">
                                                    <span class="text-sm font-medium text-secondary">AM</span>
                                                </div>
                                            </div>
                                            <div class="ml-4">
                                                <div class="text-sm font-medium text-gray-900">Ana Martínez</div>
                                                <div class="text-sm text-gray-500">ana.martinez@universidad.es</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Psicología</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-success-100 text-success">
                                            Activo
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Sin Enviar</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <button class="text-primary hover:text-primary-600">Ver Detalles</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- Teachers Table (Hidden by default) -->
                    <div id="teachersTable" class="overflow-x-auto hidden">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Docente</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Especialidad</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Estado</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Asignadas</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Acciones</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-10 w-10">
                                                <div class="h-10 w-10 rounded-full bg-accent-100 flex items-center justify-center">
                                                    <span class="text-sm font-medium text-accent">MT</span>
                                                </div>
                                            </div>
                                            <div class="ml-4">
                                                <div class="text-sm font-medium text-gray-900">Prof. Miguel Torres</div>
                                                <div class="text-sm text-gray-500">miguel.torres@universidad.es</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Ingeniería</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-success-100 text-success">
                                            Activo
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">3 tesis</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <button class="text-accent hover:text-accent-600">Ver Carga</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-10 w-10">
                                                <div class="h-10 w-10 rounded-full bg-accent-100 flex items-center justify-center">
                                                    <span class="text-sm font-medium text-accent">CL</span>
                                                </div>
                                            </div>
                                            <div class="ml-4">
                                                <div class="text-sm font-medium text-gray-900">Dra. Carmen López</div>
                                                <div class="text-sm text-gray-500">carmen.lopez@universidad.es</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Medicina</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-success-100 text-success">
                                            Activo
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">2 tesis</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <button class="text-accent hover:text-accent-600">Ver Carga</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-10 w-10">
                                                <div class="h-10 w-10 rounded-full bg-accent-100 flex items-center justify-center">
                                                    <span class="text-sm font-medium text-accent">RS</span>
                                                </div>
                                            </div>
                                            <div class="ml-4">
                                                <div class="text-sm font-medium text-gray-900">Dr. Roberto Silva</div>
                                                <div class="text-sm text-gray-500">roberto.silva@universidad.es</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Psicología</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-warning-100 text-warning">
                                            Sobrecargado
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">5 tesis</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <button class="text-accent hover:text-accent-600">Ver Carga</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Thesis Management -->
                <div class="bg-white rounded-lg border border-gray-200 p-6">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-xl font-semibold text-primary">Gestión de Tesis</h2>
                        <div class="flex items-center space-x-4">
                            <select class="form-input text-sm">
                                <option>Todas las tesis</option>
                                <option>Sin asignar</option>
                                <option>En revisión</option>
                                <option>Aprobadas</option>
                                <option>Rechazadas</option>
                            </select>
                        </div>
                    </div>

                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Estudiante</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Título</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Estado</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Evaluador</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Acciones</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">María González</td>
                                    <td class="px-6 py-4 text-sm text-gray-500">
                                        <div class="max-w-xs truncate">Optimización de Procesos Industriales en Manufactura</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-accent-100 text-accent">
                                            En Revisión
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Prof. Miguel Torres</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium space-x-2">
                                        <button class="text-primary hover:text-primary-600">Ver</button>
                                        <button class="text-accent hover:text-accent-600">Reasignar</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">Pedro Sánchez</td>
                                    <td class="px-6 py-4 text-sm text-gray-500">
                                        <div class="max-w-xs truncate">Análisis de Datos en Sistemas de Salud Digital</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-warning-100 text-warning">
                                            Sin Asignar
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">-</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium space-x-2">
                                        <button class="text-primary hover:text-primary-600">Ver</button>
                                        <button class="text-success hover:text-success-600" onclick="showAssignModal('Pedro Sánchez', 'Medicina')">Asignar</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">Laura Fernández</td>
                                    <td class="px-6 py-4 text-sm text-gray-500">
                                        <div class="max-w-xs truncate">Impacto Psicológico en Terapias Virtuales</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-warning-100 text-warning">
                                            Sin Asignar
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">-</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium space-x-2">
                                        <button class="text-primary hover:text-primary-600">Ver</button>
                                        <button class="text-success hover:text-success-600" onclick="showAssignModal('Laura Fernández', 'Psicología')">Asignar</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Right Sidebar -->
            <div class="space-y-6">
                <!-- Quick Actions -->
                <div class="bg-white rounded-lg border border-gray-200 p-6">
                    <h3 class="text-lg font-semibold text-primary mb-4">Acciones Rápidas</h3>
                    <div class="space-y-3">
                        <button class="w-full btn-primary text-sm py-3" onclick="showBulkAssignModal()">
                            <svg class="w-4 h-4 mr-2 inline" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                            </svg>
                            Asignación Masiva
                        </button>
                        <button class="w-full btn-secondary text-sm py-3">
                            <svg class="w-4 h-4 mr-2 inline" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                            </svg>
                            Exportar Reporte
                        </button>
                        <button class="w-full btn-accent text-sm py-3">
                            <svg class="w-4 h-4 mr-2 inline" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-5 5v-5zM4 17h5l-5 5v-5zM12 12l8-8m0 0l-8 8m8-8v8"/>
                            </svg>
                            Notificaciones
                        </button>
                    </div>
                </div>

                <!-- System Analytics -->
                <div class="bg-white rounded-lg border border-gray-200 p-6">
                    <h3 class="text-lg font-semibold text-primary mb-4">Análisis del Sistema</h3>
                    <div class="space-y-4">
                        <div class="flex items-center justify-between">
                            <span class="text-sm text-text-secondary">Tesis Completadas</span>
                            <span class="text-sm font-medium text-success"><%= tesisCompletadasPorcentaje %>%</span>
                        </div>
                        <div class="w-full bg-gray-200 rounded-full h-2">
                            <div class="bg-success h-2 rounded-full" style="width: <%= tesisCompletadasPorcentaje %>%"></div>
                        </div>

                        <div class="flex items-center justify-between">
                            <span class="text-sm text-text-secondary">Carga Docentes</span>
                            <span class="text-sm font-medium text-warning"><%= cargaDocentesPorcentaje %>%</span>
                        </div>
                        <div class="w-full bg-gray-200 rounded-full h-2">
                            <div class="bg-warning h-2 rounded-full" style="width: <%= cargaDocentesPorcentaje %>%"></div>
                        </div>

                        <div class="flex items-center justify-between">
                            <span class="text-sm text-text-secondary">Eficiencia</span>
                            <span class="text-sm font-medium text-primary"><%= eficienciaPorcentaje %>%</span>
                        </div>
                        <div class="w-full bg-gray-200 rounded-full h-2">
                            <div class="bg-primary h-2 rounded-full" style="width: <%= eficienciaPorcentaje %>%"></div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity -->
                <div class="bg-white rounded-lg border border-gray-200 p-6">
                    <h3 class="text-lg font-semibold text-primary mb-4">Actividad Reciente</h3>
                    <div class="space-y-3">
                        <div class="flex items-start space-x-3">
                            <div class="w-2 h-2 bg-success rounded-full mt-2"></div>
                            <div>
                                <p class="text-sm text-gray-900">Tesis de Carlos Ruiz aprobada</p>
                                <p class="text-xs text-gray-500">Hace 2 horas</p>
                            </div>
                        </div>
                        <div class="flex items-start space-x-3">
                            <div class="w-2 h-2 bg-accent rounded-full mt-2"></div>
                            <div>
                                <p class="text-sm text-gray-900">Asignada tesis a Dra. López</p>
                                <p class="text-xs text-gray-500">Hace 4 horas</p>
                            </div>
                        </div>
                        <div class="flex items-start space-x-3">
                            <div class="w-2 h-2 bg-secondary rounded-full mt-2"></div>
                            <div>
                                <p class="text-sm text-gray-900">Nuevo estudiante registrado</p>
                                <p class="text-xs text-gray-500">Hace 6 horas</p>
                            </div>
                        </div>
                        <div class="flex items-start space-x-3">
                            <div class="w-2 h-2 bg-primary rounded-full mt-2"></div>
                            <div>
                                <p class="text-sm text-gray-900">Tesis subida por Ana Martín</p>
                                <p class="text-xs text-gray-500">Hace 1 día</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Assignment Modal -->
    <div id="assignModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 hidden items-center justify-center z-50">
        <div class="bg-white rounded-lg p-6 max-w-md w-full mx-4">
            <h3 class="text-lg font-semibold text-primary mb-4">Asignar Evaluador</h3>
            <div class="space-y-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Estudiante</label>
                    <input type="text" id="studentName" class="form-input" readonly>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Área de Estudio</label>
                    <input type="text" id="studyArea" class="form-input" readonly>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Docente Evaluador</label>
                    <select id="teacherSelect" class="form-input">
                        <option value="">Seleccionar docente...</option>
                        <option value="miguel-torres">Prof. Miguel Torres (Ingeniería) - 3 tesis</option>
                        <option value="carmen-lopez">Dra. Carmen López (Medicina) - 2 tesis</option>
                        <option value="roberto-silva">Dr. Roberto Silva (Psicología) - 5 tesis</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Fecha Límite</label>
                    <input type="date" class="form-input">
                </div>
                <div class="flex space-x-3 pt-4">
                    <button class="btn-primary flex-1" onclick="assignThesis()">Asignar</button>
                    <button class="btn-secondary flex-1" onclick="closeAssignModal()">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Create User Modal -->
    <div id="createUserModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 hidden items-center justify-center z-50">
        <div class="bg-white rounded-lg p-6 max-w-md w-full mx-4">
            <h3 class="text-lg font-semibold text-primary mb-4" id="createUserTitle">Crear Nuevo Usuario</h3>
            <div class="space-y-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Nombre Completo</label>
                    <input type="text" class="form-input" placeholder="Nombre y apellidos">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Email Institucional</label>
                    <input type="email" class="form-input" placeholder="usuario@universidad.es">
                </div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Nombre Completo</label>
                    <input type="text" class="form-input" placeholder="Nombre y apellidos">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Email Institucional</label>
                    <input type="email" class="form-input" placeholder="usuario@universidad.es">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Tipo de Usuario</label>
                    <select id="userTypeSelect" class="form-input">
                        <option value="student">Estudiante</option>
                        <option value="teacher">Docente</option>
                    </select>
                </div>
                <div id="studentFields">
                    <label class="block text-sm font-medium text-gray-700 mb-2">Carrera</label>
                    <select class="form-input">
                        <option>Ingeniería Industrial</option>
                        <option>Medicina</option>
                        <option>Psicología</option>
                        <option>Derecho</option>
                        <option>Administración</option>
                    </select>
                </div>
                <div id="teacherFields" class="hidden">
                    <label class="block text-sm font-medium text-gray-700 mb-2">Especialidad</label>
                    <select class="form-input">
                        <option>Ingeniería</option>
                        <option>Medicina</option>
                        <option>Psicología</option>
                        <option>Derecho</option>
                        <option>Administración</option>
                    </select>
                </div>
                <div class="flex space-x-3 pt-4">
                    <button class="btn-primary flex-1" onclick="createUser()">Crear Usuario</button>
                    <button class="btn-secondary flex-1" onclick="closeCreateUserModal()">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script>
        // Navigation functions
        function showUserTab(tab) {
            const studentsTab = document.getElementById('studentsTab');
            const teachersTab = document.getElementById('teachersTab');
            const studentsTable = document.getElementById('studentsTable');
            const teachersTable = document.getElementById('teachersTable');

            if (tab === 'students') {
                studentsTab.className = 'py-2 px-1 border-b-2 border-primary text-primary font-medium text-sm';
                teachersTab.className = 'py-2 px-1 border-b-2 border-transparent text-text-secondary hover:text-primary text-sm';
                studentsTable.classList.remove('hidden');
                teachersTable.classList.add('hidden');
            } else {
                teachersTab.className = 'py-2 px-1 border-b-2 border-primary text-primary font-medium text-sm';
                studentsTab.className = 'py-2 px-1 border-b-2 border-transparent text-text-secondary hover:text-primary text-sm';
                teachersTable.classList.remove('hidden');
                studentsTable.classList.add('hidden');
            }
        }

        // Assignment Modal functions
        function showAssignModal(studentName, area) {
            document.getElementById('studentName').value = studentName;
            document.getElementById('studyArea').value = area;
            document.getElementById('assignModal').classList.remove('hidden');
            document.getElementById('assignModal').classList.add('flex');
        }

        function closeAssignModal() {
            document.getElementById('assignModal').classList.add('hidden');
            document.getElementById('assignModal').classList.remove('flex');
        }

        function assignThesis() {
            const teacher = document.getElementById('teacherSelect').value;
            if (teacher) {
                alert('Tesis asignada exitosamente');
                closeAssignModal();
                // Aquí iría la lógica para actualizar la base de datos
            } else {
                alert('Por favor selecciona un docente evaluador');
            }
        }

        // Create User Modal functions
        function showCreateUserModal(userType) {
            document.getElementById('createUserModal').classList.remove('hidden');
            document.getElementById('createUserModal').classList.add('flex');
            
            const userTypeSelect = document.getElementById('userTypeSelect');
            const studentFields = document.getElementById('studentFields');
            const teacherFields = document.getElementById('teacherFields');
            const title = document.getElementById('createUserTitle');

            userTypeSelect.value = userType;
            
            if (userType === 'student') {
                title.textContent = 'Crear Nuevo Estudiante';
                studentFields.classList.remove('hidden');
                teacherFields.classList.add('hidden');
            } else {
                title.textContent = 'Crear Nuevo Docente';
                teacherFields.classList.remove('hidden');
                studentFields.classList.add('hidden');
            }
        }

        function closeCreateUserModal() {
            document.getElementById('createUserModal').classList.add('hidden');
            document.getElementById('createUserModal').classList.remove('flex');
        }

        function createUser() {
            alert('Usuario creado exitosamente');
            closeCreateUserModal();
            // Aquí iría la lógica para crear el usuario en la base de datos
        }

        // Bulk assignment modal
        function showBulkAssignModal() {
            alert('Función de asignación masiva - Próximamente');
            // Aquí se implementaría el modal de asignación masiva
        }

        // Logout function
        function logout() {
            if (confirm('¿Estás seguro de que quieres cerrar sesión?')) {
                window.location.href = 'index.jsp';
            }
        }

        // User type change handler
        document.getElementById('userTypeSelect').addEventListener('change', function() {
            const studentFields = document.getElementById('studentFields');
            const teacherFields = document.getElementById('teacherFields');
            
            if (this.value === 'student') {
                studentFields.classList.remove('hidden');
                teacherFields.classList.add('hidden');
            } else {
                teacherFields.classList.remove('hidden');
                studentFields.classList.add('hidden');
            }
        });

        // Close modals when clicking outside
        window.addEventListener('click', function(e) {
            const assignModal = document.getElementById('assignModal');
            const createUserModal = document.getElementById('createUserModal');
            
            if (e.target === assignModal) {
                closeAssignModal();
            }
            if (e.target === createUserModal) {
                closeCreateUserModal();
            }
        });
    </script>
</body>
</html>