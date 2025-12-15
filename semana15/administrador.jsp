<%@page import="java.text.SimpleDateFormat"%>
<%@page import="DB.DatabaseConnection"%>
<%@page import="Modelos.Tesis"%>
<%@page import="Modelos.Tesis"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Administrador - ThesisReview Portal</title>
    <meta name="description" content="Panel de control del administrador para gestión integral de usuarios, tesis y asignaciones en ThesisReview Portal">
   <style>
    /* Estilos para las secciones */
    .section {
        display: none;
    }
    .section.active {
        display: block;
    }
    
    .assign-section {
        display: none;
    }
    .assign-section.active {
        display: block;
    }
    
    /* Transiciones suaves */
    .transition-all {
        transition: all 0.3s ease-in-out;
    }
    
    /* Scroll suave */
    html {
        scroll-behavior: smooth;
    }
    
    /* Estilos de alertas */
    .alert {
        padding: 1rem;
        border-radius: 0.5rem;
        margin-bottom: 1rem;
    }
    .alert-success {
        background-color: #d1fae5;
        color: #065f46;
        border: 1px solid #10b981;
    }
    .alert-error {
        background-color: #fee2e2;
        color: #991b1b;
        border: 1px solid #ef4444;
    }
    .alert-warning {
        background-color: #fef3c7;
        color: #92400e;
        border: 1px solid #f59e0b;
    }
    
    /* Estilos del menú activo */
    .nav-btn.active {
        color: #1e40af;
        font-weight: 500;
        border-bottom: 2px solid #1e40af;
    }
    
    .nav-btn {
        color: #6b7280;
        padding: 8px 0;
        margin: 0 15px;
        background: none;
        border: none;
        cursor: pointer;
        font-size: 14px;
        border-bottom: 2px solid transparent;
    }
    
    .nav-btn:hover {
        color: #1e40af;
    }
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

@import url('https://fonts.googleapis.com/css2?family=Crimson+Text:wght@400;600&display=swap');
 /* Estilos personalizados para el nuevo fondo y logo */
        body {
          background: linear-gradient(135deg, #e3f2fd 0%, #f8fbff 50%, #e3f2fd 100%);
          min-height: 100vh;
        }

        .logo-img {
          width: 40px;
          height: 40px;
          border-radius: 50%;
          object-fit: cover;
          box-shadow: 0 0 10px rgba(59, 130, 246, 0.3);
        }

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
1. Reset the default placeholder opacity in Firefox. (https://github.com/tailwindcss/tailwindcss/issues/3300)
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
<body>
    <%
        // PROCESAR ACCIONES DEL FORMULARIO
        String action = request.getParameter("action");
        String message = "";
        String messageType = "";
        
        if (action != null) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            
            try {
                conn = DatabaseConnection.getConnection();
                
                switch(action) {
                    case "create_user":
                        String tipoUsuario = request.getParameter("tipo_usuario");
String nombre = request.getParameter("nombre");
String apellido = request.getParameter("apellido");
String email = request.getParameter("email");
String password = request.getParameter("password");

String tipoNormalizado;
if ("student".equalsIgnoreCase(tipoUsuario)) {
    tipoNormalizado = "ESTUDIANTE";
} else if ("teacher".equalsIgnoreCase(tipoUsuario)) {
    tipoNormalizado = "DOCENTE";
} else {
    tipoNormalizado = tipoUsuario;
}

String sqlUsuario = "INSERT INTO usuarios (nombre, apellido, email, password, tipo, estado) VALUES (?, ?, ?, ?, ?, 'ACTIVO')";
pstmt = conn.prepareStatement(sqlUsuario, Statement.RETURN_GENERATED_KEYS);
pstmt.setString(1, nombre);
pstmt.setString(2, apellido);
pstmt.setString(3, email);
pstmt.setString(4, password);
pstmt.setString(5, tipoNormalizado);

int affectedRows = pstmt.executeUpdate();

if (affectedRows > 0) {
    ResultSet generatedKeys = pstmt.getGeneratedKeys();
    if (generatedKeys.next()) {
        int userId = generatedKeys.getInt(1);
        
        if ("ESTUDIANTE".equals(tipoNormalizado)) {
            String codigo = request.getParameter("codigo_estudiante");
            int carreraId = Integer.parseInt(request.getParameter("carrera_id"));
            
            String sqlEstudiante = "INSERT INTO estudiantes (id, codigo_estudiante, carrera_id, estado_tesis) VALUES (?, ?, ?, 'SIN_ENVIAR')";
            pstmt = conn.prepareStatement(sqlEstudiante);
            pstmt.setInt(1, userId);
            pstmt.setString(2, codigo);
            pstmt.setInt(3, carreraId);
            pstmt.executeUpdate();
            
            message = "Estudiante creado exitosamente";
        } else if ("DOCENTE".equals(tipoNormalizado)) {
            String especialidad = request.getParameter("especialidad");
            String titulo = request.getParameter("titulo");
            int capacidad = Integer.parseInt(request.getParameter("capacidad_maxima"));
            
            String sqlDocente = "INSERT INTO docentes (id, especialidad, titulo, capacidad_maxima) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sqlDocente);
            pstmt.setInt(1, userId);
            pstmt.setString(2, especialidad);
            pstmt.setString(3, titulo);
            pstmt.setInt(4, capacidad);
            pstmt.executeUpdate();
            
            message = "Docente creado exitosamente";
        }
    }
    messageType = "success";
}
break;
                        
                    case "assign_thesis":
                        int tesisId = Integer.parseInt(request.getParameter("tesis_id"));
                        int docenteId = Integer.parseInt(request.getParameter("docente_id"));
                        String fechaLimite = request.getParameter("fecha_limite");
                        
                        String sqlTesis = "UPDATE tesis SET estado = 'EN_REVISION' WHERE id = ?";
                        pstmt = conn.prepareStatement(sqlTesis);
                        pstmt.setInt(1, tesisId);
                        pstmt.executeUpdate();
                        
                        String sqlAsignacion = "INSERT INTO asignaciones_evaluacion (tesis_id, docente_id, admin_asignador, fecha_limite, estado) VALUES (?, ?, 1, ?, 'EN_PROGRESO')";
                        pstmt = conn.prepareStatement(sqlAsignacion);
                        pstmt.setInt(1, tesisId);
                        pstmt.setInt(2, docenteId);
                        pstmt.setString(3, fechaLimite);
                        pstmt.executeUpdate();
                        
                        String sqlActualizarDocente = "UPDATE docentes SET tesis_asignadas = tesis_asignadas + 1, carga_trabajo = ROUND(((tesis_asignadas + 1) / capacidad_maxima) * 100, 2) WHERE id = ?";
                        pstmt = conn.prepareStatement(sqlActualizarDocente);
                        pstmt.setInt(1, docenteId);
                        pstmt.executeUpdate();
                        
                        message = "Tesis asignada exitosamente al docente";
                        messageType = "success";
                        break;
                        
                    case "upload_thesis":
                    try {
        System.out.println("=== PROCESANDO UPLOAD_THESIS ===");
        
        // Debug: mostrar todos los parámetros
        java.util.Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            System.out.println("Parámetro: " + paramName + " = " + request.getParameter(paramName));
        }
        
        // Obtener parámetros con validación
        String estudianteIdStr = request.getParameter("estudiante_id");
        String titulo = request.getParameter("titulo");
        String resumen = request.getParameter("resumen");
        String palabrasClave = request.getParameter("palabras_clave");
        
        // Validar que no sean nulos
        if (estudianteIdStr == null || estudianteIdStr.trim().isEmpty()) {
            message = "Error: El ID del estudiante es obligatorio";
            messageType = "error";
            System.out.println("ERROR: estudiante_id es null o vacío");
            break;
        }
        
        if (titulo == null || titulo.trim().isEmpty()) {
            message = "Error: El título es obligatorio";
            messageType = "error";
            System.out.println("ERROR: titulo es null o vacío");
            break;
        }
        
        // Convertir y validar ID
        int estudianteId;
        try {
            estudianteId = Integer.parseInt(estudianteIdStr.trim());
        } catch (NumberFormatException e) {
            message = "Error: ID de estudiante inválido";
            messageType = "error";
            System.out.println("ERROR: No se puede convertir estudiante_id a número: " + estudianteIdStr);
            break;
        }
        
        // Verificar que el estudiante existe
        String sqlVerificarEstudiante = "SELECT COUNT(*) FROM estudiantes WHERE id = ?";
        PreparedStatement pstmtVerificar = conn.prepareStatement(sqlVerificarEstudiante);
        pstmtVerificar.setInt(1, estudianteId);
        java.sql.ResultSet rsVerificar = pstmtVerificar.executeQuery();
        rsVerificar.next();
        int existeEstudiante = rsVerificar.getInt(1);
        rsVerificar.close();
        pstmtVerificar.close();
        
        if (existeEstudiante == 0) {
            message = "Error: El estudiante con ID " + estudianteId + " no existe";
            messageType = "error";
            System.out.println("ERROR: Estudiante no existe en la base de datos");
            break;
        }
        
        // Obtener año académico actual
        java.util.Calendar cal = java.util.Calendar.getInstance();
        int anoAcademico = cal.get(java.util.Calendar.YEAR);
        
        // SQL para insertar tesis - usando la estructura de tu ejemplo
        String sqlInsert = "INSERT INTO tesis (estudiante_id, titulo, resumen, palabras_clave, estado, nivel_estudio, semestre, ano_academico) VALUES (?, ?, ?, ?, 'BORRADOR', 'PREGRADO', 10, ?)";
        
        System.out.println("SQL a ejecutar: " + sqlInsert);
        System.out.println("Valores:");
        System.out.println("  estudiante_id: " + estudianteId);
        System.out.println("  titulo: " + titulo);
        System.out.println("  resumen: " + (resumen != null ? resumen.substring(0, Math.min(resumen.length(), 50)) + "..." : "null"));
        System.out.println("  palabras_clave: " + palabrasClave);
        System.out.println("  ano_academico: " + anoAcademico);
        
        // Preparar y ejecutar la sentencia
        pstmt = conn.prepareStatement(sqlInsert);
        pstmt.setInt(1, estudianteId);
        pstmt.setString(2, titulo);
        pstmt.setString(3, resumen != null ? resumen : "");
        pstmt.setString(4, palabrasClave != null ? palabrasClave : "");
        pstmt.setInt(5, anoAcademico);
        
        int filasAfectadas = pstmt.executeUpdate();
        System.out.println("Filas afectadas: " + filasAfectadas);
        
        if (filasAfectadas > 0) {
            // Actualizar estado del estudiante
            try {
                String sqlActualizarEstudiante = "UPDATE estudiantes SET estado_tesis = 'BORRADOR' WHERE id = ?";
                PreparedStatement pstmtActualizar = conn.prepareStatement(sqlActualizarEstudiante);
                pstmtActualizar.setInt(1, estudianteId);
                pstmtActualizar.executeUpdate();
                pstmtActualizar.close();
                System.out.println("Estado del estudiante actualizado");
            } catch (SQLException e) {
                System.out.println("Advertencia: No se pudo actualizar estado del estudiante: " + e.getMessage());
            }
            
            message = "¡Tesis creada exitosamente!";
            messageType = "success";
            System.out.println("SUCCESS: Tesis creada correctamente");
        } else {
            message = "Error: No se pudo crear la tesis";
            messageType = "error";
            System.out.println("ERROR: 0 filas afectadas en la inserción");
        }
        
    } catch (SQLException e) {
        message = "Error de base de datos: " + e.getMessage();
        messageType = "error";
        System.out.println("SQL EXCEPTION:");
        System.out.println("  Mensaje: " + e.getMessage());
        System.out.println("  SQL State: " + e.getSQLState());
        System.out.println("  Error Code: " + e.getErrorCode());
        e.printStackTrace();
    } catch (Exception e) {
        message = "Error inesperado: " + e.getMessage();
        messageType = "error";
        System.out.println("EXCEPTION: " + e.getMessage());
        e.printStackTrace();
    }
    break;

                }
                
            } catch (Exception e) {
                message = "Error: " + e.getMessage();
                messageType = "error";
                e.printStackTrace();
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        }
        
        // OBTENER ESTADÍSTICAS
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int estudiantesActivos = 0;
        int docentesEvaluadores = 0;
        int tesisTotales = 0;
        int tesisSinAsignar = 0;
        int tesisAprobadas = 0;
        int tesisEnRevision = 0;
        int cargaDocentesPorcentaje = 0;
        int eficienciaPorcentaje = 0;
        
        // DATOS PARA REPORTES
        Map<String, Integer> tesisPorCarrera = new HashMap<>();
        Map<String, Integer> tesisPorEstado = new HashMap<>();
        Map<String, Integer> asignacionesPorMes = new HashMap<>();
        List<Map<String, Object>> evaluacionesRecientes = new ArrayList<>();
        
        String nombreAdmin = "Admin García";
        
        try {
            conn = DatabaseConnection.getConnection();
            
            String sqlEstudiantes = "SELECT COUNT(*) as total FROM usuarios WHERE tipo = 'ESTUDIANTE' AND estado = 'ACTIVO'";
            pstmt = conn.prepareStatement(sqlEstudiantes);
            rs = pstmt.executeQuery();
            if (rs.next()) estudiantesActivos = rs.getInt("total");
            
            String sqlDocentes = "SELECT COUNT(*) as total FROM usuarios WHERE tipo = 'DOCENTE' AND estado = 'ACTIVO'";
            pstmt = conn.prepareStatement(sqlDocentes);
            rs = pstmt.executeQuery();
            if (rs.next()) docentesEvaluadores = rs.getInt("total");
            
            String sqlTesisTotales = "SELECT COUNT(*) as total FROM tesis";
            pstmt = conn.prepareStatement(sqlTesisTotales);
            rs = pstmt.executeQuery();
            if (rs.next()) tesisTotales = rs.getInt("total");
            
            String sqlTesisSinAsignar = "SELECT COUNT(*) as total FROM tesis WHERE estado IN ('SIN_ENVIAR', 'BORRADOR')";
            pstmt = conn.prepareStatement(sqlTesisSinAsignar);
            rs = pstmt.executeQuery();
            if (rs.next()) tesisSinAsignar = rs.getInt("total");
            
            String sqlTesisAprobadas = "SELECT COUNT(*) as total FROM tesis WHERE estado = 'APROBADA'";
            pstmt = conn.prepareStatement(sqlTesisAprobadas);
            rs = pstmt.executeQuery();
            if (rs.next()) tesisAprobadas = rs.getInt("total");
            
            String sqlTesisEnRevision = "SELECT COUNT(*) as total FROM tesis WHERE estado = 'EN_REVISION'";
            pstmt = conn.prepareStatement(sqlTesisEnRevision);
            rs = pstmt.executeQuery();
            if (rs.next()) tesisEnRevision = rs.getInt("total");
            
            String sqlCargaDocentes = "SELECT ROUND(AVG(carga_trabajo), 0) as promedio FROM docentes";
            pstmt = conn.prepareStatement(sqlCargaDocentes);
            rs = pstmt.executeQuery();
            if (rs.next()) cargaDocentesPorcentaje = rs.getInt("promedio");
            
            String sqlEficiencia = "SELECT ROUND((COUNT(CASE WHEN estado = 'COMPLETADA' AND fecha_completada <= fecha_limite THEN 1 END) / NULLIF(COUNT(*), 0)) * 100, 0) as eficiencia FROM asignaciones_evaluacion WHERE estado = 'COMPLETADA'";
            pstmt = conn.prepareStatement(sqlEficiencia);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                eficienciaPorcentaje = rs.getInt("eficiencia");
                if (eficienciaPorcentaje == 0) eficienciaPorcentaje = 92;
            }
            
            // CONSULTAS PARA REPORTES
            // Tesis por carrera
            String sqlTesisPorCarrera = "SELECT c.nombre as carrera, COUNT(t.id) as cantidad " +
                                       "FROM tesis t " +
                                       "JOIN estudiantes e ON t.estudiante_id = e.id " +
                                       "JOIN carreras c ON e.carrera_id = c.id " +
                                       "GROUP BY c.nombre " +
                                       "ORDER BY cantidad DESC";
            pstmt = conn.prepareStatement(sqlTesisPorCarrera);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                tesisPorCarrera.put(rs.getString("carrera"), rs.getInt("cantidad"));
            }
            
            // Tesis por estado
            String sqlTesisPorEstado = "SELECT estado, COUNT(*) as cantidad " +
                                      "FROM tesis " +
                                      "GROUP BY estado";
            pstmt = conn.prepareStatement(sqlTesisPorEstado);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                tesisPorEstado.put(rs.getString("estado"), rs.getInt("cantidad"));
            }
            
            // Evaluaciones recientes
            String sqlEvaluacionesRecientes = "SELECT ae.id, t.titulo, " +
                                            "CONCAT(u.nombre, ' ', u.apellido) as estudiante, " +
                                            "CONCAT(ud.nombre, ' ', ud.apellido) as docente, " +
                                            "ae.fecha_asignacion, ae.fecha_limite, ae.estado " +
                                            "FROM asignaciones_evaluacion ae " +
                                            "JOIN tesis t ON ae.tesis_id = t.id " +
                                            "JOIN estudiantes e ON t.estudiante_id = e.id " +
                                            "JOIN usuarios u ON e.id = u.id " +
                                            "JOIN docentes d ON ae.docente_id = d.id " +
                                            "JOIN usuarios ud ON d.id = ud.id " +
                                            "ORDER BY ae.fecha_asignacion DESC " +
                                            "LIMIT 10";
            pstmt = conn.prepareStatement(sqlEvaluacionesRecientes);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> evaluacion = new HashMap<>();
                evaluacion.put("id", rs.getInt("id"));
                evaluacion.put("titulo", rs.getString("titulo"));
                evaluacion.put("estudiante", rs.getString("estudiante"));
                evaluacion.put("docente", rs.getString("docente"));
                evaluacion.put("fecha_asignacion", rs.getDate("fecha_asignacion"));
                evaluacion.put("fecha_limite", rs.getDate("fecha_limite"));
                evaluacion.put("estado", rs.getString("estado"));
                evaluacionesRecientes.add(evaluacion);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            estudiantesActivos = 245;
            docentesEvaluadores = 18;
            tesisTotales = 67;
            tesisSinAsignar = 12;
            cargaDocentesPorcentaje = 85;
            eficienciaPorcentaje = 92;
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    %>

    
    <%
    // Mostrar mensajes de éxito/error de sesión
    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) session.getAttribute("errorMessage");
    
    if (successMessage != null) {
%>
<div id="statusMessage" style="position: fixed; top: 20px; right: 20px; z-index: 1000; padding: 15px; border-radius: 5px; background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb;">
    <%= successMessage %>
</div>
<script>
    setTimeout(() => {
        document.getElementById('statusMessage').style.display = 'none';
    }, 5000);
</script>
<%
        session.removeAttribute("successMessage");
    }
    
    if (errorMessage != null) {
%>
<div id="errorMessage" style="position: fixed; top: 20px; right: 20px; z-index: 1000; padding: 15px; border-radius: 5px; background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;">
    <%= errorMessage %>
</div>
<script>
    setTimeout(() => {
        document.getElementById('errorMessage').style.display = 'none';
    }, 5000);
</script>
<%
        session.removeAttribute("errorMessage");
    }
%>
    <!-- Mensaje de estado -->
    <% if (!message.isEmpty()) { %>
    <div id="statusMessage" style="position: fixed; top: 20px; right: 20px; z-index: 1000; padding: 15px; border-radius: 5px; background-color: <%= "success".equals(messageType) ? "#d4edda" : "error".equals(messageType) ? "#f8d7da" : "#d1ecf1" %>; color: <%= "success".equals(messageType) ? "#155724" : "error".equals(messageType) ? "#721c24" : "#0c5460" %>; border: 1px solid <%= "success".equals(messageType) ? "#c3e6cb" : "error".equals(messageType) ? "#f5c6cb" : "#bee5eb" %>;">
        <%= message %>
    </div>
    <script>
        setTimeout(() => {
            document.getElementById('statusMessage').style.display = 'none';
        }, 5000);
    </script>
    <% } %>

    <!-- Navegación -->
    <nav style="background: white; border-bottom: 1px solid #e5e7eb; position: sticky; top: 0; z-index: 50;">
        <div style="max-width: 1200px; margin: 0 auto; padding: 0 20px;">
            <div style="display: flex; justify-content: space-between; align-items: center; height: 64px;">
                <!-- Logo -->
                <div style="display: flex; align-items: center;">
                    <img src="upla.png" alt="Logo" style="width: 40px; height: 40px; border-radius: 50%;">
                    <span style="margin-left: 10px; font-size: 20px; font-weight: bold; color: #1e40af;">ThesisReview</span>
                    <span style="margin-left: 15px; padding: 4px 8px; background: #dbeafe; color: #1e40af; border-radius: 9999px; font-size: 12px;">Administrador</span>
                </div>
                
                <!-- Enlaces de navegación -->
                <div style="display: flex; align-items: center; gap: 32px;">
                    <button onclick="showSection('dashboard')" class="nav-btn active" data-section="dashboard">Inicio</button>
                    <button onclick="showSection('assign-section')" class="nav-btn" data-section="assign-section">Asignar</button>
                    <button onclick="showSection('upload-section')" class="nav-btn" data-section="upload-section">Subir Tesis</button>
                    <button onclick="showSection('reports-section')" class="nav-btn" data-section="reports-section">Reportes</button>
                </div>

                <!-- Menú de usuario -->
                <div style="display: flex; align-items: center; gap: 16px;">
                    <div style="display: flex; align-items: center; gap: 8px;">
                        <div style="width: 32px; height: 32px; background: #1e40af; border-radius: 9999px; display: flex; align-items: center; justify-content: center;">
                            <svg style="width: 16px; height: 16px; color: white;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                            </svg>
                        </div>
                        <span style="font-size: 14px; font-weight: 500;"><%= nombreAdmin %></span>
                    </div>
                    <button onclick="window.location.href='${pageContext.request.contextPath}/logout';" style="color: #6b7280;">
                        <svg style="width: 20px; height: 20px;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                        </svg>
                    </button>
                </div>
            </div>
        </div>
    </nav>

    <!-- Contenido principal -->
    <main style="max-width: 1200px; margin: 0 auto; padding: 32px 20px;">
        
        <!-- DASHBOARD (Sección activa por defecto) -->
        <div id="dashboard" class="section active">
           <div id="dashboard" style="margin-bottom: 32px;">
            <h1 style="font-size: 30px; font-weight: bold; color: #1e40af; margin-bottom: 8px;">Panel de Administrador</h1>
            <p style="color: #6b7280;">Gestión integral del ecosistema de tesis académicas</p>
        </div>

        <!-- Estadísticas -->
        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 24px; margin-bottom: 32px;">
            <!-- Estudiantes Activos -->
            <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px;">
                <div style="display: flex; align-items: center;">
                    <div style="width: 48px; height: 48px; background: #dbeafe; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-right: 16px;">
                        <svg style="width: 24px; height: 24px; color: #3b82f6;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"/>
                        </svg>
                    </div>
                    <div>
                        <p style="font-size: 24px; font-weight: bold; color: #1e40af;"><%= estudiantesActivos %></p>
                        <p style="font-size: 14px; color: #6b7280;">Estudiantes Activos</p>
                    </div>
                </div>
            </div>

            <!-- Docentes Evaluadores -->
            <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px;">
                <div style="display: flex; align-items: center;">
                    <div style="width: 48px; height: 48px; background: #ffedd5; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-right: 16px;">
                        <svg style="width: 24px; height: 24px; color: #f97316;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z"/>
                        </svg>
                    </div>
                    <div>
                        <p style="font-size: 24px; font-weight: bold; color: #1e40af;"><%= docentesEvaluadores %></p>
                        <p style="font-size: 14px; color: #6b7280;">Docentes Evaluadores</p>
                    </div>
                </div>
            </div>

            <!-- Tesis Totales -->
            <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px;">
                <div style="display: flex; align-items: center;">
                    <div style="width: 48px; height: 48px; background: #dbeafe; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-right: 16px;">
                        <svg style="width: 24px; height: 24px; color: #1e40af;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                    </div>
                    <div>
                        <p style="font-size: 24px; font-weight: bold; color: #1e40af;"><%= tesisTotales %></p>
                        <p style="font-size: 14px; color: #6b7280;">Tesis Totales</p>
                    </div>
                </div>
            </div>

            <!-- Tesis Sin Asignar -->
            <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px;">
                <div style="display: flex; align-items: center;">
                    <div style="width: 48px; height: 48px; background: #fef3c7; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-right: 16px;">
                        <svg style="width: 24px; height: 24px; color: #f59e0b;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <div>
                        <p style="font-size: 24px; font-weight: bold; color: #1e40af;"><%= tesisSinAsignar %></p>
                        <p style="font-size: 14px; color: #6b7280;">Sin Asignar</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Gestión de Usuarios -->
        <div id="users-section" style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; margin-bottom: 32px;">
            <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 24px;">
                <h2 style="font-size: 20px; font-weight: 600; color: #1e40af;">Gestión de Usuarios</h2>
                <div style="display: flex; gap: 8px;">
                    <button onclick="showCreateUserModal('student')" style="background: #3b82f6; color: white; padding: 8px 16px; border-radius: 6px; font-weight: 600; font-size: 14px;">
                        + Estudiante
                    </button>
                    <button onclick="showCreateUserModal('teacher')" style="background: #f97316; color: white; padding: 8px 16px; border-radius: 6px; font-weight: 600; font-size: 14px;">
                        + Docente
                    </button>
                </div>
            </div>

            <!-- Pestañas -->
            <div style="border-bottom: 1px solid #e5e7eb; margin-bottom: 24px;">
                <div style="display: flex; gap: 32px;">
                    <button id="studentsTab" onclick="showUserTab('students')" style="padding: 8px 0; border-bottom: 2px solid #1e40af; color: #1e40af; font-weight: 500; font-size: 14px;">
                        Estudiantes (<%= estudiantesActivos %>)
                    </button>
                    <button id="teachersTab" onclick="showUserTab('teachers')" style="padding: 8px 0; border-bottom: 2px solid transparent; color: #6b7280; font-size: 14px;">
                        Docentes (<%= docentesEvaluadores %>)
                    </button>
                </div>
            </div>

            <!-- Tabla de Estudiantes -->
            <div id="studentsTable">
                <table style="width: 100%; border-collapse: collapse;">
                    <thead style="background: #f9fafb;">
                        <tr>
                            <th style="padding: 12px 24px; text-align: left; font-size: 12px; font-weight: 500; color: #6b7280; text-transform: uppercase;">Usuario</th>
                            <th style="padding: 12px 24px; text-align: left; font-size: 12px; font-weight: 500; color: #6b7280; text-transform: uppercase;">Carrera</th>
                            <th style="padding: 12px 24px; text-align: left; font-size: 12px; font-weight: 500; color: #6b7280; text-transform: uppercase;">Estado</th>
                            <th style="padding: 12px 24px; text-align: left; font-size: 12px; font-weight: 500; color: #6b7280; text-transform: uppercase;">Tesis</th>
                            <th style="padding: 12px 24px; text-align: left; font-size: 12px; font-weight: 500; color: #6b7280; text-transform: uppercase;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection connEst = null;
                            PreparedStatement pstmtEst = null;
                            ResultSet rsEst = null;

                            try {
                                connEst = DatabaseConnection.getConnection();
                                String sql = "SELECT u.id, u.nombre, u.apellido, u.email, u.estado, u.tipo, "
                                        + "e.codigo_estudiante, c.nombre as carrera, e.estado_tesis "
                                        + "FROM usuarios u "
                                        + "JOIN estudiantes e ON u.id = e.id "
                                        + "JOIN carreras c ON e.carrera_id = c.id "
                                        + "WHERE u.tipo IN ('ESTUDIANTE', 'EST') "
                                        + // Incluye ambos valores por si acaso
                                        "LIMIT 5";

                                pstmtEst = connEst.prepareStatement(sql);
                                rsEst = pstmtEst.executeQuery();

                                while (rsEst.next()) {
                                    // VARIABLES A DECLARAR:
                                    int usuarioId = rsEst.getInt("id");
                                    String tipoUsuario = rsEst.getString("tipo");
                                    String nombre = rsEst.getString("nombre");
                                    String apellido = rsEst.getString("apellido");
                                    String email = rsEst.getString("email");
                                    String estado = rsEst.getString("estado");

                                    // Opcional: convertir "EST" a "ESTUDIANTE" para mostrar mejor
                                    String tipoMostrar = "EST".equals(tipoUsuario) ? "ESTUDIANTE" : tipoUsuario;

                                    // Nombre completo para la tabla
                                    String nombreCompleto = nombre + " " + apellido;
                                    String carrera = rsEst.getString("carrera");
                                    String estadoTesis = rsEst.getString("estado_tesis");
                        %>
                        <tr style="border-top: 1px solid #e5e7eb;">
    <td style="padding: 16px 24px;">
        <div style="display: flex; align-items: center;">
            <div style="width: 40px; height: 40px; background: #dbeafe; border-radius: 9999px; display: flex; align-items: center; justify-content: center; margin-right: 16px;">
                <span style="font-size: 14px; font-weight: 500; color: #3b82f6;">
                    <%= nombre.substring(0, 1) + apellido.substring(0, 1) %>
                </span>
            </div>
            <div>
                <div style="font-size: 14px; font-weight: 500; color: #111827;"><%= nombreCompleto %></div>
                <div style="font-size: 14px; color: #6b7280;"><%= email %></div>
            </div>
        </div>
    </td>
    <td style="padding: 16px 24px; font-size: 14px; color: #6b7280;"><%= carrera %></td>
    <td style="padding: 16px 24px;">
        <span style="display: inline-flex; align-items: center; padding: 4px 10px; background: #d1fae5; color: #065f46; border-radius: 9999px; font-size: 12px; font-weight: 500;">
            <%= estado %>
        </span>
    </td>
    <td style="padding: 16px 24px; font-size: 14px; color: #6b7280;">
        <%= estadoTesis.equals("APROBADA") ? "Aprobada" : 
           estadoTesis.equals("EN_REVISION") ? "En Revisión" : 
           estadoTesis.equals("BORRADOR") ? "Borrador" : 
           "Sin Enviar" %>
    </td>
    <td style="padding: 16px 24px; font-size: 14px; font-weight: 500;">
        <!-- BOTÓN CORREGIDO -->
        <button onclick="showUserDetailModal(
            <%= usuarioId %>, 
            '<%= tipoUsuario %>', 
            '<%= nombre %>', 
            '<%= apellido %>', 
            '<%= email %>', 
            '<%= estado %>'
        )" style="color: #1e40af; margin-right: 8px;">Ver Detalles</button>
        <!-- Elimina el segundo botón que está duplicado -->
    </td>
</tr>
<%
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (rsEst != null) try { rsEst.close(); } catch (Exception e) {}
    if (pstmtEst != null) try { pstmtEst.close(); } catch (Exception e) {}
    if (connEst != null) try { connEst.close(); } catch (Exception e) {}
}
%>
                    </tbody>
                </table>
            </div>

            <!-- Tabla de Docentes -->
            <div id="teachersTable" style="display: none;">
                <table style="width: 100%; border-collapse: collapse;">
                    <thead style="background: #f9fafb;">
                        <tr>
                            <th style="padding: 12px 24px; text-align: left; font-size: 12px; font-weight: 500; color: #6b7280; text-transform: uppercase;">Docente</th>
                            <th style="padding: 12px 24px; text-align: left; font-size: 12px; font-weight: 500; color: #6b7280; text-transform: uppercase;">Especialidad</th>
                            <th style="padding: 12px 24px; text-align: left; font-size: 12px; font-weight: 500; color: #6b7280; text-transform: uppercase;">Estado</th>
                            <th style="padding: 12px 24px; text-align: left; font-size: 12px; font-weight: 500; color: #6b7280; text-transform: uppercase;">Asignadas</th>
                            <th style="padding: 12px 24px; text-align: left; font-size: 12px; font-weight: 500; color: #6b7280; text-transform: uppercase;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection connDoc = null;
                            PreparedStatement pstmtDoc = null;
                            ResultSet rsDoc = null;
                            
                            try {
                                connDoc = DatabaseConnection.getConnection();
                                String sql = "SELECT u.id, u.nombre, u.apellido, u.email, u.estado, " +
                                           "d.especialidad, d.titulo, d.tesis_asignadas, d.carga_trabajo, d.capacidad_maxima " +
                                           "FROM usuarios u " +
                                           "JOIN docentes d ON u.id = d.id " +
                                           "WHERE u.tipo = 'DOCENTE' " +
                                           "LIMIT 5";
                                
                                pstmtDoc = connDoc.prepareStatement(sql);
                                rsDoc = pstmtDoc.executeQuery();
                                
                                while (rsDoc.next()) {
                                    String nombreCompleto = rsDoc.getString("titulo") + " " + rsDoc.getString("nombre") + " " + rsDoc.getString("apellido");
                                    String email = rsDoc.getString("email");
                                    String especialidad = rsDoc.getString("especialidad");
                                    String estado = rsDoc.getString("estado");
                                    int tesisAsignadas = rsDoc.getInt("tesis_asignadas");
                                    int capacidadMaxima = rsDoc.getInt("capacidad_maxima");
                                    double cargaTrabajo = rsDoc.getDouble("carga_trabajo");
                                    
                                    String estadoClase = "background: #d1fae5; color: #065f46;";
                                    String estadoTexto = "Activo";
                                    
                                    if (cargaTrabajo >= 90) {
                                        estadoClase = "background: #fef3c7; color: #92400e;";
                                        estadoTexto = "Sobrecargado";
                                    } else if (cargaTrabajo >= 70) {
                                        estadoClase = "background: #ffedd5; color: #9a3412;";
                                        estadoTexto = "Alta Carga";
                                    }
                        %>
                        <tr style="border-top: 1px solid #e5e7eb;">
                            <td style="padding: 16px 24px;">
                                <div style="display: flex; align-items: center;">
                                    <div style="width: 40px; height: 40px; background: #ffedd5; border-radius: 9999px; display: flex; align-items: center; justify-content: center; margin-right: 16px;">
                                        <span style="font-size: 14px; font-weight: 500; color: #f97316;">
                                            <%= rsDoc.getString("nombre").substring(0, 1) + rsDoc.getString("apellido").substring(0, 1) %>
                                        </span>
                                    </div>
                                    <div>
                                        <div style="font-size: 14px; font-weight: 500; color: #111827;"><%= nombreCompleto %></div>
                                        <div style="font-size: 14px; color: #6b7280;"><%= email %></div>
                                    </div>
                                </div>
                            </td>
                            <td style="padding: 16px 24px; font-size: 14px; color: #6b7280;"><%= especialidad %></td>
                            <td style="padding: 16px 24px;">
                                <span style="display: inline-flex; align-items: center; padding: 4px 10px; <%= estadoClase %> border-radius: 9999px; font-size: 12px; font-weight: 500;">
                                    <%= estadoTexto %>
                                </span>
                            </td>
                            <td style="padding: 16px 24px; font-size: 14px; color: #6b7280;">
                                <%= tesisAsignadas %> de <%= capacidadMaxima %> tesis
                            </td>
                            <td style="padding: 16px 24px; font-size: 14px; font-weight: 500;">
                                <button style="color: #f97316;">Ver Carga</button>
                            </td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rsDoc != null) try { rsDoc.close(); } catch (Exception e) {}
                                if (pstmtDoc != null) try { pstmtDoc.close(); } catch (Exception e) {}
                                if (connDoc != null) try { connDoc.close(); } catch (Exception e) {}
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Gestión de Tesis -->
        <div id="thesis-section" style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; margin-bottom: 32px;">
            <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 24px;">
                <h2 style="font-size: 20px; font-weight: 600; color: #1e40af;">Gestión de Tesis</h2>
                <div>
                    <select onchange="filtrarTesis(this.value)" style="padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; font-size: 14px;">
                        <option value="todas">Todas las tesis</option>
                        <option value="sin_asignar">Sin asignar</option>
                        <option value="en_revision">En revisión</option>
                        <option value="aprobadas">Aprobadas</option>
                        <option value="rechazadas">Rechazadas</option>
                    </select>
                </div>
            </div>

            <div>
                <table style="width: 100%; border-collapse: collapse;">
                    <thead style="background: #f9fafb;">
                        <tr>
                            <th style="padding: 12px 24px; text-align: left; font-size: 12px; font-weight: 500; color: #6b7280; text-transform: uppercase;">Estudiante</th>
                            <th style="padding: 12px 24px; text-align: left; font-size: 12px; font-weight: 500; color: #6b7280; text-transform: uppercase;">Título</th>
                            <th style="padding: 12px 24px; text-align: left; font-size: 12px; font-weight: 500; color: #6b7280; text-transform: uppercase;">Estado</th>
                            <th style="padding: 12px 24px; text-align: left; font-size: 12px; font-weight: 500; color: #6b7280; text-transform: uppercase;">Evaluador</th>
                            <th style="padding: 12px 24px; text-align: left; font-size: 12px; font-weight: 500; color: #6b7280; text-transform: uppercase;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody id="tablaTesis">
                        <%
                            Connection connTes = null;
                            PreparedStatement pstmtTes = null;
                            ResultSet rsTes = null;
                            
                            try {
                                connTes = DatabaseConnection.getConnection();
                                String sql = "SELECT t.id, t.titulo, t.estado, t.fecha_creacion, " +
                                           "CONCAT(u.nombre, ' ', u.apellido) as estudiante, " +
                                           "c.nombre as carrera, " +
                                           "(SELECT CONCAT(ud.nombre, ' ', ud.apellido) " +
                                           " FROM asignaciones_evaluacion ae " +
                                           " JOIN usuarios ud ON ae.docente_id = ud.id " +
                                           " WHERE ae.tesis_id = t.id AND ae.estado IN ('PENDIENTE', 'EN_PROGRESO') " +
                                           " LIMIT 1) as evaluador " +
                                           "FROM tesis t " +
                                           "JOIN estudiantes e ON t.estudiante_id = e.id " +
                                           "JOIN usuarios u ON e.id = u.id " +
                                           "JOIN carreras c ON e.carrera_id = c.id " +
                                           "ORDER BY t.fecha_creacion DESC " +
                                           "LIMIT 5";
                                
                                pstmtTes = connTes.prepareStatement(sql);
                                rsTes = pstmtTes.executeQuery();
                                
                                while (rsTes.next()) {
                                    String titulo = rsTes.getString("titulo");
                                    String estudiante = rsTes.getString("estudiante");
                                    String estado = rsTes.getString("estado");
                                    String evaluador = rsTes.getString("evaluador");
                                    String carrera = rsTes.getString("carrera");
                                    
                                    String estadoClase = "";
                                    String estadoTexto = "";
                                    
                                    switch(estado) {
                                        case "EN_REVISION":
                                            estadoClase = "background: #ffedd5; color: #9a3412;";
                                            estadoTexto = "En Revisión";
                                            break;
                                        case "SIN_ENVIAR":
                                        case "BORRADOR":
                                            estadoClase = "background: #fef3c7; color: #92400e;";
                                            estadoTexto = "Sin Asignar";
                                            break;
                                        case "APROBADA":
                                            estadoClase = "background: #d1fae5; color: #065f46;";
                                            estadoTexto = "Aprobada";
                                            break;
                                        case "RECHAZADA":
                                            estadoClase = "background: #fee2e2; color: #991b1b;";
                                            estadoTexto = "Rechazada";
                                            break;
                                        default:
                                            estadoClase = "background: #f3f4f6; color: #374151;";
                                            estadoTexto = estado;
                                    }
                        %>
                        <tr style="border-top: 1px solid #e5e7eb;" data-estado="<%= estado.toLowerCase() %>">
                            <td style="padding: 16px 24px; font-size: 14px; font-weight: 500; color: #111827;"><%= estudiante %></td>
                            <td style="padding: 16px 24px; font-size: 14px; color: #6b7280; max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                <%= titulo %>
                            </td>
                            <td style="padding: 16px 24px;">
                                <span style="display: inline-flex; align-items: center; padding: 4px 10px; <%= estadoClase %> border-radius: 9999px; font-size: 12px; font-weight: 500;">
                                    <%= estadoTexto %>
                                </span>
                            </td>
                            <td style="padding: 16px 24px; font-size: 14px; color: #6b7280;">
                                <%= (evaluador != null && !evaluador.isEmpty()) ? evaluador : "-" %>
                            </td>
                            <td style="padding: 16px 24px; font-size: 14px; font-weight: 500;">
                                <button onclick="verTesis(<%= rsTes.getInt("id") %>)" style="color: #1e40af; margin-right: 8px;">Ver</button>
                                <button onclick="showAssignModal('<%= estudiante %>', '<%= carrera %>', <%= rsTes.getInt("id") %>)" style="color: <%= estado.equals("SIN_ENVIAR") || estado.equals("BORRADOR") ? "#10b981" : "#f97316" %>;">
                                    <%= estado.equals("SIN_ENVIAR") || estado.equals("BORRADOR") ? "Asignar" : "Reasignar" %>
                                </button>
                            </td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rsTes != null) try { rsTes.close(); } catch (Exception e) {}
                                if (pstmtTes != null) try { pstmtTes.close(); } catch (Exception e) {}
                                if (connTes != null) try { connTes.close(); } catch (Exception e) {}
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

            </div>
        </div>
        <!-- ASIGNAR TESIS -->
        <div id="assign-section" class="section">
            <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; margin-bottom: 32px;">
                <h2 style="font-size: 20px; font-weight: 600; color: #1e40af; margin-bottom: 24px;">Asignar Tesis a Evaluadores</h2>
                <p style="color: #6b7280; margin-bottom: 24px;">Seleccione tesis pendientes y asígnelas a docentes evaluadores</p>
                
                <!-- Estadísticas Rápidas -->
                <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; margin-bottom: 24px;">
                    <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 20px;">
                        <div style="display: flex; align-items: center;">
                            <div style="width: 40px; height: 40px; background: #dbeafe; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-right: 12px;">
                                <svg style="width: 20px; height: 20px; color: #1e40af;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                </svg>
                            </div>
                            <div>
                                <p style="font-size: 20px; font-weight: bold; color: #1e40af;"><%= tesisSinAsignar %></p>
                                <p style="font-size: 12px; color: #6b7280;">Tesis Pendientes</p>
                            </div>
                        </div>
                    </div>
                    
                    <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 20px;">
                        <div style="display: flex; align-items: center;">
                            <div style="width: 40px; height: 40px; background: #ffedd5; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-right: 12px;">
                                <svg style="width: 20px; height: 20px; color: #f97316;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z"/>
                                </svg>
                            </div>
                            <div>
                                <p style="font-size: 20px; font-weight: bold; color: #1e40af;"><%= docentesEvaluadores %></p>
                                <p style="font-size: 12px; color: #6b7280;">Docentes Disponibles</p>
                            </div>
                        </div>
                    </div>
                    
                    <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 20px;">
                        <div style="display: flex; align-items: center;">
                            <div style="width: 40px; height: 40px; background: #d1fae5; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-right: 12px;">
                                <svg style="width: 20px; height: 20px; color: #10b981;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                            </div>
                            <div>
                                <p style="font-size: 20px; font-weight: bold; color: #1e40af;"><%= cargaDocentesPorcentaje %>%</p>
                                <p style="font-size: 12px; color: #6b7280;">Capacidad Disponible</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Formulario de Asignación -->
                <div style="background: #f8fafc; border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; margin-bottom: 24px;">
                    <h3 style="font-size: 18px; font-weight: 600; color: #1e40af; margin-bottom: 20px;">Formulario de Asignación</h3>
                    
                    <form id="assignFormSection" method="post" action="administrador.jsp">
                        <input type="hidden" name="action" value="assign_thesis">
                        
                        <div style="display: grid; gap: 20px;">
                            <!-- Selección de Tesis -->
                            <div>
                                <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">
                                    Seleccionar Tesis <span style="color: #ef4444;">*</span>
                                </label>
                                <select name="tesis_id" id="tesisSelect" style="width: 100%; padding: 10px 12px; border: 1px solid #e5e7eb; border-radius: 6px; font-size: 14px;" required onchange="actualizarInfoTesis(this.value)">
                                    <option value="">Seleccionar tesis...</option>
                                    <%
                                        Connection connTes2 = null;
                                        PreparedStatement pstmtTes2 = null;
                                        ResultSet rsTes2 = null;
                                        
                                        try {
                                            connTes2 = DatabaseConnection.getConnection();
                                            String sql = "SELECT t.id, t.titulo, t.estado, t.fecha_creacion, " +
                                                       "CONCAT(u.nombre, ' ', u.apellido) as estudiante, " +
                                                       "c.nombre as carrera " +
                                                       "FROM tesis t " +
                                                       "JOIN estudiantes e ON t.estudiante_id = e.id " +
                                                       "JOIN usuarios u ON e.id = u.id " +
                                                       "JOIN carreras c ON e.carrera_id = c.id " +
                                                       "WHERE t.estado IN ('SIN_ENVIAR', 'BORRADOR') " +
                                                       "ORDER BY t.fecha_creacion";
                                            
                                            pstmtTes2 = connTes2.prepareStatement(sql);
                                            rsTes2 = pstmtTes2.executeQuery();
                                            
                                            while (rsTes2.next()) {
                                                String titulo = rsTes2.getString("titulo");
                                                String estudiante = rsTes2.getString("estudiante");
                                                String carrera = rsTes2.getString("carrera");
                                                java.sql.Date fechaCreacion = rsTes2.getDate("fecha_creacion");
                                                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                                                String fechaFormateada = fechaCreacion != null ? sdf.format(fechaCreacion) : "N/A";
                                                
                                                String tituloDisplay = titulo.length() > 60 ? 
                                                    titulo.substring(0, 60) + "..." : titulo;
                                    %>
                                    <option value="<%= rsTes2.getInt("id") %>" 
                                            data-titulo="<%= titulo %>"
                                            data-estudiante="<%= estudiante %>"
                                            data-carrera="<%= carrera %>"
                                            data-fecha="<%= fechaFormateada %>">
                                        <%= tituloDisplay %> - <%= estudiante %> (<%= carrera %>)
                                    </option>
                                    <%
                                            }
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        } finally {
                                            if (rsTes2 != null) try { rsTes2.close(); } catch (Exception e) {}
                                            if (pstmtTes2 != null) try { pstmtTes2.close(); } catch (Exception e) {}
                                            if (connTes2 != null) try { connTes2.close(); } catch (Exception e) {}
                                        }
                                    %>
                                </select>
                                
                                <!-- Información de la tesis seleccionada -->
                                <div id="tesisInfo" style="margin-top: 16px; padding: 16px; background: #dbeafe; border-radius: 6px; border: 1px solid #bfdbfe; display: none;">
                                    <h4 style="font-size: 14px; font-weight: 600; color: #1e40af; margin-bottom: 12px;">Información de la Tesis</h4>
                                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px;">
                                        <div>
                                            <p style="font-size: 11px; font-weight: 600; color: #1e40af; text-transform: uppercase; margin-bottom: 4px;">Título:</p>
                                            <p id="tesisTitulo" style="font-size: 13px; color: #374151; word-break: break-word;"></p>
                                        </div>
                                        <div>
                                            <p style="font-size: 11px; font-weight: 600; color: #1e40af; text-transform: uppercase; margin-bottom: 4px;">Estudiante:</p>
                                            <p id="tesisEstudiante" style="font-size: 13px; color: #374151;"></p>
                                        </div>
                                        <div>
                                            <p style="font-size: 11px; font-weight: 600; color: #1e40af; text-transform: uppercase; margin-bottom: 4px;">Carrera:</p>
                                            <p id="tesisCarrera" style="font-size: 13px; color: #374151;"></p>
                                        </div>
                                        <div>
                                            <p style="font-size: 11px; font-weight: 600; color: #1e40af; text-transform: uppercase; margin-bottom: 4px;">Fecha Creación:</p>
                                            <p id="tesisFecha" style="font-size: 13px; color: #374151;"></p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Selección de Docente -->
                            <div>
                                <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">
                                    Seleccionar Docente Evaluador <span style="color: #ef4444;">*</span>
                                </label>
                                <select name="docente_id" id="docenteSelect" style="width: 100%; padding: 10px 12px; border: 1px solid #e5e7eb; border-radius: 6px; font-size: 14px;" required onchange="actualizarInfoDocente(this.value)">
                                    <option value="">Seleccionar docente...</option>
                                    <%
                                        Connection connDoc2 = null;
                                        PreparedStatement pstmtDoc2 = null;
                                        ResultSet rsDoc2 = null;
                                        
                                        try {
                                            connDoc2 = DatabaseConnection.getConnection();
                                            String sql = "SELECT d.id, CONCAT(d.titulo, ' ', u.nombre, ' ', u.apellido) as nombre_completo, " +
                                                       "d.especialidad, d.tesis_asignadas, d.capacidad_maxima, " +
                                                       "ROUND((d.tesis_asignadas * 100.0) / d.capacidad_maxima, 1) as carga_trabajo " +
                                                       "FROM docentes d " +
                                                       "JOIN usuarios u ON d.id = u.id " +
                                                       "WHERE u.estado = 'ACTIVO' " +
                                                       "ORDER BY d.carga_trabajo ASC, d.especialidad";
                                            pstmtDoc2 = connDoc2.prepareStatement(sql);
                                            rsDoc2 = pstmtDoc2.executeQuery();
                                            
                                            while (rsDoc2.next()) {
                                                String nombreCompleto = rsDoc2.getString("nombre_completo");
                                                String especialidad = rsDoc2.getString("especialidad");
                                                int tesisAsignadas = rsDoc2.getInt("tesis_asignadas");
                                                int capacidadMaxima = rsDoc2.getInt("capacidad_maxima");
                                                double cargaTrabajo = rsDoc2.getDouble("carga_trabajo");
                                                String disponibilidad = tesisAsignadas < capacidadMaxima ? "Disponible" : "Capacidad completa";
                                    %>
                                    <option value="<%= rsDoc2.getInt("id") %>" 
                                            data-nombre="<%= nombreCompleto %>"
                                            data-especialidad="<%= especialidad != null ? especialidad : "Sin especialidad" %>"
                                            data-asignadas="<%= tesisAsignadas %>"
                                            data-capacidad="<%= capacidadMaxima %>"
                                            data-carga="<%= cargaTrabajo %>"
                                            data-disponibilidad="<%= disponibilidad %>">
                                        <%= nombreCompleto %> (<%= especialidad != null ? especialidad : "Sin especialidad" %>) - 
                                        <%= tesisAsignadas %>/<%= capacidadMaxima %> tesis - 
                                        <%= String.format("%.1f", cargaTrabajo) %>% carga
                                    </option>
                                    <%
                                            }
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        } finally {
                                            if (rsDoc2 != null) try { rsDoc2.close(); } catch (Exception e) {}
                                            if (pstmtDoc2 != null) try { pstmtDoc2.close(); } catch (Exception e) {}
                                            if (connDoc2 != null) try { connDoc2.close(); } catch (Exception e) {}
                                        }
                                    %>
                                </select>
                                
                                
                                <!-- Información del docente seleccionado -->
                                <div id="docenteInfo" style="margin-top: 16px; padding: 16px; background: #ffedd5; border-radius: 6px; border: 1px solid #fed7aa; display: none;">
                                    <h4 style="font-size: 14px; font-weight: 600; color: #f97316; margin-bottom: 12px;">Información del Docente</h4>
                                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px;">
                                        <div>
                                            <p style="font-size: 11px; font-weight: 600; color: #f97316; text-transform: uppercase; margin-bottom: 4px;">Docente:</p>
                                            <p id="docenteNombre" style="font-size: 13px; color: #374151;"></p>
                                        </div>
                                        <div>
                                            <p style="font-size: 11px; font-weight: 600; color: #f97316; text-transform: uppercase; margin-bottom: 4px;">Especialidad:</p>
                                            <p id="docenteEspecialidad" style="font-size: 13px; color: #374151;"></p>
                                        </div>
                                        <div style="grid-column: span 2;">
                                            <p style="font-size: 11px; font-weight: 600; color: #f97316; text-transform: uppercase; margin-bottom: 4px;">Carga Actual:</p>
                                            <div style="display: flex; align-items: center;">
                                                <div style="flex: 1; background: #e5e7eb; border-radius: 9999px; height: 8px; margin-right: 8px;">
                                                    <div id="docenteCargaBar" style="height: 8px; border-radius: 9999px; background: #f97316; transition: width 0.3s;"></div>
                                                </div>
                                                <span id="docenteCarga" style="font-size: 12px; font-weight: 600; color: #f97316;"></span>
                                            </div>
                                        </div>
                                        <div>
                                            <p style="font-size: 11px; font-weight: 600; color: #f97316; text-transform: uppercase; margin-bottom: 4px;">Tesis Asignadas:</p>
                                            <p id="docenteTesis" style="font-size: 13px; color: #374151;"></p>
                                        </div>
                                        <div>
                                            <p style="font-size: 11px; font-weight: 600; color: #f97316; text-transform: uppercase; margin-bottom: 4px;">Disponibilidad:</p>
                                            <p id="docenteDisponibilidad" style="font-size: 13px; color: #374151;"></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                                
                                <!-- Docente 2 -->
                <div style="margin-bottom: 15px;">
                    <label style="display: block; font-size: 12px; font-weight: 500; color: #374151; margin-bottom: 6px;">
                        Docente 2 (Opcional)
                    </label>
                    <select name="docente_id[]" id="docenteSelect2" style="width: 100%; padding: 10px 12px; border: 1px solid #e5e7eb; border-radius: 6px; font-size: 14px;" onchange="actualizarInfoDocente(2, this.value)">
                        <option value="">Seleccionar docente 2...</option>
                        <option value="0">No asignar segundo docente</option>
                        <%
                            // Reabrir la conexión para el segundo select
                            Connection connDoc3 = null;
                            PreparedStatement pstmtDoc3 = null;
                            ResultSet rsDoc3 = null;
                            
                            try {
                                connDoc3 = DatabaseConnection.getConnection();
                                String sql = "SELECT d.id, CONCAT(d.titulo, ' ', u.nombre, ' ', u.apellido) as nombre_completo, " +
                                           "d.especialidad, d.tesis_asignadas, d.capacidad_maxima, " +
                                           "ROUND((d.tesis_asignadas * 100.0) / d.capacidad_maxima, 1) as carga_trabajo " +
                                           "FROM docentes d " +
                                           "JOIN usuarios u ON d.id = u.id " +
                                           "WHERE u.estado = 'ACTIVO' " +
                                           "ORDER BY d.carga_trabajo ASC, d.especialidad";
                                pstmtDoc3 = connDoc3.prepareStatement(sql);
                                rsDoc3 = pstmtDoc3.executeQuery();
                                
                                while (rsDoc3.next()) {
                                    String nombreCompleto = rsDoc3.getString("nombre_completo");
                                    String especialidad = rsDoc3.getString("especialidad");
                                    int tesisAsignadas = rsDoc3.getInt("tesis_asignadas");
                                    int capacidadMaxima = rsDoc3.getInt("capacidad_maxima");
                                    double cargaTrabajo = rsDoc3.getDouble("carga_trabajo");
                                    String disponibilidad = tesisAsignadas < capacidadMaxima ? "Disponible" : "Capacidad completa";
                        %>
                        <option value="<%= rsDoc3.getInt("id") %>" 
                                data-nombre="<%= nombreCompleto %>"
                                data-especialidad="<%= especialidad != null ? especialidad : "Sin especialidad" %>"
                                data-asignadas="<%= tesisAsignadas %>"
                                data-capacidad="<%= capacidadMaxima %>"
                                data-carga="<%= cargaTrabajo %>"
                                data-disponibilidad="<%= disponibilidad %>">
                            <%= nombreCompleto %> (<%= especialidad != null ? especialidad : "Sin especialidad" %>) - 
                            <%= tesisAsignadas %>/<%= capacidadMaxima %> tesis - 
                            <%= String.format("%.1f", cargaTrabajo) %>% carga
                        </option>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rsDoc3 != null) try { rsDoc3.close(); } catch (Exception e) {}
                                if (pstmtDoc3 != null) try { pstmtDoc3.close(); } catch (Exception e) {}
                                if (connDoc3 != null) try { connDoc3.close(); } catch (Exception e) {}
                            }
                        %>
                    </select>
                    
                    <!-- Información del docente 2 -->
                    <div id="docenteInfo2" style="margin-top: 8px; padding: 12px; background: #ffedd5; border-radius: 6px; border: 1px solid #fed7aa; display: none;">
                        <h4 style="font-size: 13px; font-weight: 600; color: #f97316; margin-bottom: 8px;">Docente 2</h4>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 8px;">
                            <div>
                                <p style="font-size: 10px; font-weight: 600; color: #f97316; text-transform: uppercase; margin-bottom: 4px;">Docente:</p>
                                <p id="docenteNombre2" style="font-size: 12px; color: #374151;"></p>
                            </div>
                            <div>
                                <p style="font-size: 10px; font-weight: 600; color: #f97316; text-transform: uppercase; margin-bottom: 4px;">Especialidad:</p>
                                <p id="docenteEspecialidad2" style="font-size: 12px; color: #374151;"></p>
                            </div>
                            <div style="grid-column: span 2;">
                                <p style="font-size: 10px; font-weight: 600; color: #f97316; text-transform: uppercase; margin-bottom: 4px;">Carga Actual:</p>
                                <div style="display: flex; align-items: center;">
                                    <div style="flex: 1; background: #e5e7eb; border-radius: 9999px; height: 6px; margin-right: 6px;">
                                        <div id="docenteCargaBar2" style="height: 6px; border-radius: 9999px; background: #f97316; transition: width 0.3s;"></div>
                                    </div>
                                    <span id="docenteCarga2" style="font-size: 11px; font-weight: 600; color: #f97316;"></span>
                                </div>
                            </div>
                            <div>
                                <p style="font-size: 10px; font-weight: 600; color: #f97316; text-transform: uppercase; margin-bottom: 4px;">Disponibilidad:</p>
                                <p id="docenteDisponibilidad2" style="font-size: 12px; color: #374151;"></p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Docente 3 -->
                <div style="margin-bottom: 15px;">
                    <label style="display: block; font-size: 12px; font-weight: 500; color: #374151; margin-bottom: 6px;">
                        Docente 3 (Opcional)
                    </label>
                    <select name="docente_id[]" id="docenteSelect3" style="width: 100%; padding: 10px 12px; border: 1px solid #e5e7eb; border-radius: 6px; font-size: 14px;" onchange="actualizarInfoDocente(3, this.value)">
                        <option value="">Seleccionar docente 3...</option>
                        <option value="0">No asignar tercer docente</option>
                        <%
                            // Reabrir la conexión para el tercer select
                            Connection connDoc4 = null;
                            PreparedStatement pstmtDoc4 = null;
                            ResultSet rsDoc4 = null;
                            
                            try {
                                connDoc4 = DatabaseConnection.getConnection();
                                String sql = "SELECT d.id, CONCAT(d.titulo, ' ', u.nombre, ' ', u.apellido) as nombre_completo, " +
                                           "d.especialidad, d.tesis_asignadas, d.capacidad_maxima, " +
                                           "ROUND((d.tesis_asignadas * 100.0) / d.capacidad_maxima, 1) as carga_trabajo " +
                                           "FROM docentes d " +
                                           "JOIN usuarios u ON d.id = u.id " +
                                           "WHERE u.estado = 'ACTIVO' " +
                                           "ORDER BY d.carga_trabajo ASC, d.especialidad";
                                pstmtDoc4 = connDoc4.prepareStatement(sql);
                                rsDoc4 = pstmtDoc4.executeQuery();
                                
                                while (rsDoc4.next()) {
                                    String nombreCompleto = rsDoc4.getString("nombre_completo");
                                    String especialidad = rsDoc4.getString("especialidad");
                                    int tesisAsignadas = rsDoc4.getInt("tesis_asignadas");
                                    int capacidadMaxima = rsDoc4.getInt("capacidad_maxima");
                                    double cargaTrabajo = rsDoc4.getDouble("carga_trabajo");
                                    String disponibilidad = tesisAsignadas < capacidadMaxima ? "Disponible" : "Capacidad completa";
                        %>
                        <option value="<%= rsDoc4.getInt("id") %>" 
                                data-nombre="<%= nombreCompleto %>"
                                data-especialidad="<%= especialidad != null ? especialidad : "Sin especialidad" %>"
                                data-asignadas="<%= tesisAsignadas %>"
                                data-capacidad="<%= capacidadMaxima %>"
                                data-carga="<%= cargaTrabajo %>"
                                data-disponibilidad="<%= disponibilidad %>">
                            <%= nombreCompleto %> (<%= especialidad != null ? especialidad : "Sin especialidad" %>) - 
                            <%= tesisAsignadas %>/<%= capacidadMaxima %> tesis - 
                            <%= String.format("%.1f", cargaTrabajo) %>% carga
                        </option>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rsDoc4 != null) try { rsDoc4.close(); } catch (Exception e) {}
                                if (pstmtDoc4 != null) try { pstmtDoc4.close(); } catch (Exception e) {}
                                if (connDoc4 != null) try { connDoc4.close(); } catch (Exception e) {}
                            }
                        %>
                    </select>
                    
                    <!-- Información del docente 3 -->
                    <div id="docenteInfo3" style="margin-top: 8px; padding: 12px; background: #ffedd5; border-radius: 6px; border: 1px solid #fed7aa; display: none;">
                        <h4 style="font-size: 13px; font-weight: 600; color: #f97316; margin-bottom: 8px;">Docente 3</h4>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 8px;">
                            <div>
                                <p style="font-size: 10px; font-weight: 600; color: #f97316; text-transform: uppercase; margin-bottom: 4px;">Docente:</p>
                                <p id="docenteNombre3" style="font-size: 12px; color: #374151;"></p>
                            </div>
                            <div>
                                <p style="font-size: 10px; font-weight: 600; color: #f97316; text-transform: uppercase; margin-bottom: 4px;">Especialidad:</p>
                                <p id="docenteEspecialidad3" style="font-size: 12px; color: #374151;"></p>
                            </div>
                            <div style="grid-column: span 2;">
                                <p style="font-size: 10px; font-weight: 600; color: #f97316; text-transform: uppercase; margin-bottom: 4px;">Carga Actual:</p>
                                <div style="display: flex; align-items: center;">
                                    <div style="flex: 1; background: #e5e7eb; border-radius: 9999px; height: 6px; margin-right: 6px;">
                                        <div id="docenteCargaBar3" style="height: 6px; border-radius: 9999px; background: #f97316; transition: width 0.3s;"></div>
                                    </div>
                                    <span id="docenteCarga3" style="font-size: 11px; font-weight: 600; color: #f97316;"></span>
                                </div>
                            </div>
                            <div>
                                <p style="font-size: 10px; font-weight: 600; color: #f97316; text-transform: uppercase; margin-bottom: 4px;">Disponibilidad:</p>
                                <p id="docenteDisponibilidad3" style="font-size: 12px; color: #374151;"></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

                            <!-- Fecha y Comentarios -->
                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                                <div>
                                    <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">
                                        Fecha Límite de Evaluación <span style="color: #ef4444;">*</span>
                                    </label>
                                    <%
                                        // Calcular fecha límite por defecto (30 días desde hoy)
                                        java.util.Calendar calendario = java.util.Calendar.getInstance();
                                        calendario.add(java.util.Calendar.DAY_OF_MONTH, 30);
                                        java.text.SimpleDateFormat formatoFecha = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                        String fechaLimiteDefault = formatoFecha.format(calendario.getTime());

                                        // Fecha de hoy
                                        String fechaHoy = formatoFecha.format(new java.util.Date());
                                    %>
                                    <input type="date" name="fecha_limite" id="fechaLimiteSection" style="width: 100%; padding: 10px 12px; border: 1px solid #e5e7eb; border-radius: 6px;" 
                                           value="<%= fechaLimiteDefault %>" min="<%= fechaHoy %>" required
                                           onchange="validarFechaLimite(this)">
                                    <p style="font-size: 11px; color: #6b7280; margin-top: 4px;">Fecha máxima para completar la evaluación</p>
                                    <p id="fechaError" style="font-size: 11px; color: #ef4444; margin-top: 4px; display: none;">
                                        La fecha límite no puede ser anterior a hoy
                                    </p>
                                </div>
                                
                                <div>
                                    <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Comentarios/Instrucciones</label>
                                    <textarea name="comentarios_admin" style="width: 100%; padding: 10px 12px; border: 1px solid #e5e7eb; border-radius: 6px; min-height: 80px; font-size: 14px;" 
                                              placeholder="Instrucciones adicionales para el evaluador..."></textarea>
                                    <p style="font-size: 11px; color: #6b7280; margin-top: 4px;">Estas instrucciones serán visibles para el docente asignado</p>
                                </div>
                            </div>

                            <!-- Botones -->
                            <div style="display: flex; gap: 12px; padding-top: 20px; border-top: 1px solid #e5e7eb;">
                                <button type="submit" id="submitBtn" style="flex: 1; background: #1e40af; color: white; padding: 12px; border-radius: 6px; font-weight: 600; font-size: 14px;">
                                    Asignar Tesis
                                </button>
                                <button type="button" onclick="showSection('dashboard')" style="flex: 1; background: #3b82f6; color: white; padding: 12px; border-radius: 6px; font-weight: 600; font-size: 14px; text-align: center;">
                                    Volver al Dashboard
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                
                <!-- Lista de Tesis Pendientes -->
                <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                        <h3 style="font-size: 18px; font-weight: 600; color: #1e40af;">Tesis Pendientes de Asignación</h3>
                        <span style="font-size: 12px; font-weight: 600; background: #dbeafe; color: #1e40af; padding: 4px 12px; border-radius: 9999px;">
                            <%= tesisSinAsignar %> tesis
                        </span>
                    </div>
                    
                    <%
                        Connection connTes3 = null;
                        PreparedStatement pstmtTes3 = null;
                        ResultSet rsTes3 = null;
                        
                        try {
                            connTes3 = DatabaseConnection.getConnection();
                            String sql = "SELECT t.id, t.titulo, t.estado, t.fecha_creacion, " +
                                       "CONCAT(u.nombre, ' ', u.apellido) as estudiante, " +
                                       "c.nombre as carrera " +
                                       "FROM tesis t " +
                                       "JOIN estudiantes e ON t.estudiante_id = e.id " +
                                       "JOIN usuarios u ON e.id = u.id " +
                                       "JOIN carreras c ON e.carrera_id = c.id " +
                                       "WHERE t.estado IN ('SIN_ENVIAR', 'BORRADOR') " +
                                       "ORDER BY t.fecha_creacion DESC";
                            
                            pstmtTes3 = connTes3.prepareStatement(sql);
                            rsTes3 = pstmtTes3.executeQuery();
                            
                            if (!rsTes3.isBeforeFirst()) {
                    %>
                    <div style="text-align: center; padding: 40px 20px; border: 2px dashed #d1d5db; border-radius: 8px;">
                        <p style="color: #10b981; font-size: 16px; font-weight: 600; margin-bottom: 8px;">¡Excelente trabajo!</p>
                        <p style="color: #6b7280;">No hay tesis pendientes de asignación</p>
                    </div>
                    <%
                            } else {
                    %>
                    <div style="overflow-x: auto;">
                        <table style="width: 100%; border-collapse: collapse;">
                            <thead style="background: #f9fafb;">
                                <tr>
                                    <th style="padding: 12px 16px; text-align: left; font-size: 11px; font-weight: 600; color: #6b7280; text-transform: uppercase;">ID</th>
                                    <th style="padding: 12px 16px; text-align: left; font-size: 11px; font-weight: 600; color: #6b7280; text-transform: uppercase;">Título</th>
                                    <th style="padding: 12px 16px; text-align: left; font-size: 11px; font-weight: 600; color: #6b7280; text-transform: uppercase;">Estudiante</th>
                                    <th style="padding: 12px 16px; text-align: left; font-size: 11px; font-weight: 600; color: #6b7280; text-transform: uppercase;">Carrera</th>
                                    <th style="padding: 12px 16px; text-align: left; font-size: 11px; font-weight: 600; color: #6b7280; text-transform: uppercase;">Fecha</th>
                                    <th style="padding: 12px 16px; text-align: left; font-size: 11px; font-weight: 600; color: #6b7280; text-transform: uppercase;">Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 0;
                                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                    while (rsTes3.next()) {
                                        count++;
                                        String titulo = rsTes3.getString("titulo");
                                        String estudiante = rsTes3.getString("estudiante");
                                        String carrera = rsTes3.getString("carrera");
                                        java.sql.Date fechaCreacion = rsTes3.getDate("fecha_creacion");
                                        String fechaFormateada = fechaCreacion != null ? dateFormat.format(fechaCreacion) : "N/A";
                                        
                                        String tituloTruncado = titulo.length() > 50 ? 
                                            titulo.substring(0, 50) + "..." : titulo;
                                %>
                                <tr style="border-top: 1px solid #e5e7eb; <%= count % 2 == 0 ? "background: #f9fafb;" : "" %>">
                                    <td style="padding: 16px; font-size: 13px; font-weight: 600; color: #1e40af;">
                                        #<%= rsTes3.getInt("id") %>
                                    </td>
                                    <td style="padding: 16px;">
                                        <div style="max-width: 300px;" title="<%= titulo %>">
                                            <p style="font-size: 13px; font-weight: 500; color: #111827; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%= tituloTruncado %></p>
                                        </div>
                                    </td>
                                    <td style="padding: 16px; font-size: 13px; color: #6b7280;"><%= estudiante %></td>
                                    <td style="padding: 16px; font-size: 13px; color: #6b7280;"><%= carrera %></td>
                                    <td style="padding: 16px; font-size: 13px; color: #6b7280;"><%= fechaFormateada %></td>
                                    <td style="padding: 16px; font-size: 13px; font-weight: 500;">
                                        <button onclick="seleccionarTesis(<%= rsTes3.getInt("id") %>)" style="color: #1e40af;">
                                            Asignar
                                        </button>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rsTes3 != null) try { rsTes3.close(); } catch (Exception e) {}
                            if (pstmtTes3 != null) try { pstmtTes3.close(); } catch (Exception e) {}
                            if (connTes3 != null) try { connTes3.close(); } catch (Exception e) {}
                        }
                    %>
                </div>
            </div>
        </div>

        <!-- SUBIR TESIS -->
        <!-- SUBIR TESIS -->
<div id="upload-section" class="section">
    <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px;">
        <h2 style="font-size: 20px; font-weight: 600; color: #1e40af; margin-bottom: 24px;">Crear Nueva Tesis</h2>
        
        <!-- Cambia el formulario para usar el TesisController -->
        <form id="uploadForm" method="post" action="TesisController" enctype="multipart/form-data">
            <input type="hidden" name="action" value="crear">
            
            <div style="display: grid; gap: 16px;">
                <div>
                    <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Título de la Tesis *</label>
                    <input type="text" name="titulo" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;" placeholder="Ingrese el título completo" required>
                </div>
                
                <div>
                    <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Estudiante *</label>
                    <select name="estudiante_id" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;" required>
                        <option value="">Seleccionar estudiante...</option>
                        <%
                            Connection connEst2 = null;
                            PreparedStatement pstmtEst2 = null;
                            ResultSet rsEst2 = null;
                            
                            try {
                                connEst2 = DatabaseConnection.getConnection();
                                String sql = "SELECT u.id, CONCAT(u.nombre, ' ', u.apellido, ' - ', e.codigo_estudiante) as nombre_completo " +
                                           "FROM usuarios u " +
                                           "JOIN estudiantes e ON u.id = e.id " +
                                           "WHERE u.estado = 'ACTIVO' " +
                                           "ORDER BY u.nombre";
                                pstmtEst2 = connEst2.prepareStatement(sql);
                                rsEst2 = pstmtEst2.executeQuery();
                                
                                while (rsEst2.next()) {
                        %>
                        <option value="<%= rsEst2.getInt("id") %>"><%= rsEst2.getString("nombre_completo") %></option>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rsEst2 != null) try { rsEst2.close(); } catch (Exception e) {}
                                if (pstmtEst2 != null) try { pstmtEst2.close(); } catch (Exception e) {}
                                if (connEst2 != null) try { connEst2.close(); } catch (Exception e) {}
                            }
                        %>
                    </select>
                </div>
                
                <div>
                    <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Resumen *</label>
                    <textarea name="descripcion" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; min-height: 80px;" placeholder="Breve descripción de la tesis" required></textarea>
                </div>
                
                <div>
                    <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Palabras Clave *</label>
                    <input type="text" name="palabras_clave" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;" placeholder="Separadas por comas (ej: ingeniería, software, desarrollo)" required>
                </div>
                
                <!-- Campos adicionales para el controlador -->
                <input type="hidden" name="area_estudio" value="Ingeniería">
                <input type="hidden" name="carrera" value="Ingeniería de Sistemas">
                <input type="hidden" name="nivel_estudio" value="PREGRADO">
                <input type="hidden" name="semestre" value="10">
                
                <!-- Área de arrastrar y soltar para archivos -->
                <div>
                    <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Documento de Tesis (PDF) *</label>
                    
                    <!-- Input file oculto -->
                    <input type="file" name="archivo" id="fileInput" accept=".pdf,.doc,.docx" style="display: none;" required>
                    
                    <!-- Área de arrastrar y soltar -->
                    <div id="dropArea" 
                         style="border: 2px dashed #d1d5db; border-radius: 8px; padding: 40px 20px; text-align: center; background: #f9fafb; cursor: pointer;"
                         ondrop="dropHandler(event)" 
                         ondragover="dragOverHandler(event)"
                         onclick="document.getElementById('fileInput').click()">
                         
                        <div style="margin-bottom: 16px;">
                            <svg style="width: 48px; height: 48px; color: #9ca3af; margin: 0 auto;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"/>
                            </svg>
                        </div>
                        
                        <p style="font-size: 16px; font-weight: 500; color: #374151; margin-bottom: 8px;">
                            Arrastra y suelta tu archivo aquí
                        </p>
                        <p style="font-size: 14px; color: #6b7280; margin-bottom: 16px;">
                            o haz clic para seleccionar
                        </p>
                        <p style="font-size: 12px; color: #9ca3af;">
                            Formatos aceptados: PDF, DOC, DOCX (Máx. 50MB)
                        </p>
                        
                        <!-- Información del archivo seleccionado -->
                        <div id="fileInfo" style="display: none; margin-top: 16px; padding: 12px; background: #d1fae5; border-radius: 6px;">
                            <div style="display: flex; align-items: center; justify-content: space-between;">
                                <div style="display: flex; align-items: center;">
                                    <svg style="width: 20px; height: 20px; color: #10b981; margin-right: 8px;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                    </svg>
                                    <span id="fileName" style="font-size: 14px; font-weight: 500; color: #065f46;"></span>
                                </div>
                                <button type="button" onclick="removeFile()" style="color: #ef4444; background: none; border: none; cursor: pointer;">
                                    <svg style="width: 16px; height: 16px;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                                    </svg>
                                </button>
                            </div>
                            <p id="fileSize" style="font-size: 12px; color: #065f46; margin-top: 4px;"></p>
                        </div>
                    </div>
                    
                    <!-- Progress Bar -->
                    <div id="progressContainer" style="display: none; margin-top: 12px;">
                        <div style="display: flex; justify-content: space-between; margin-bottom: 4px;">
                            <span id="progressText" style="font-size: 12px; color: #374151;">Subiendo...</span>
                            <span id="progressPercent" style="font-size: 12px; color: #3b82f6;">0%</span>
                        </div>
                        <div style="width: 100%; height: 6px; background: #e5e7eb; border-radius: 3px;">
                            <div id="progressBar" style="height: 100%; width: 0%; background: #3b82f6; border-radius: 3px; transition: width 0.3s;"></div>
                        </div>
                    </div>
                </div>
                
                <div style="display: flex; gap: 12px; margin-top: 16px;">
                    <button type="submit" id="submitBtn" style="flex: 1; background: #1e40af; color: white; padding: 12px; border-radius: 6px; font-weight: 600;">Subir Tesis</button>
                    <button type="button" onclick="resetUploadForm()" style="flex: 1; background: #3b82f6; color: white; padding: 12px; border-radius: 6px; font-weight: 600;">Limpiar</button>
                </div>
            </div>
        </form>
    </div>
</div>

        <!-- REPORTES -->
        <div id="reports-section" class="section">
            <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; margin-bottom: 32px;">
                <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 32px;">
                    <div>
                        <h2 style="font-size: 20px; font-weight: 600; color: #1e40af; margin-bottom: 8px;">Reportes del Sistema</h2>
                        <p style="color: #6b7280;">Generar reportes detallados y certificados oficiales</p>
                    </div>
                    <div style="display: flex; align-items: center; gap: 8px;">
                        <svg style="width: 20px; height: 20px; color: #1e40af;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                        <span style="font-size: 12px; font-weight: 600; color: #1e40af;">Panel de Reportes</span>
                    </div>
                </div>

                <!-- Resumen de métricas -->
                <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 32px;">
                    <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 20px;">
                        <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 12px;">
                            <span style="font-size: 12px; font-weight: 600; color: #6b7280; text-transform: uppercase;">Reportes Generados</span>
                            <div style="width: 24px; height: 24px; background: #dbeafe; border-radius: 6px; display: flex; align-items: center; justify-content: center;">
                                <span style="font-size: 10px; font-weight: 600; color: #1e40af;">18</span>
                            </div>
                        </div>
                        <p style="font-size: 24px; font-weight: bold; color: #1e40af;">156</p>
                        <p style="font-size: 12px; color: #10b981;">+12 este mes</p>
                    </div>

                    <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 20px;">
                        <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 12px;">
                            <span style="font-size: 12px; font-weight: 600; color: #6b7280; text-transform: uppercase;">Certificados Emitidos</span>
                            <div style="width: 24px; height: 24px; background: #d1fae5; border-radius: 6px; display: flex; align-items: center; justify-content: center;">
                                <span style="font-size: 10px; font-weight: 600; color: #10b981;">24</span>
                            </div>
                        </div>
                        <p style="font-size: 24px; font-weight: bold; color: #1e40af;"><%= tesisAprobadas %></p>
                        <p style="font-size: 12px; color: #10b981;"><%= String.format("%.1f", (tesisAprobadas * 100.0) / (tesisTotales > 0 ? tesisTotales : 1)) %>% aprobación</p>
                    </div>

                    <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 20px;">
                        <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 12px;">
                            <span style="font-size: 12px; font-weight: 600; color: #6b7280; text-transform: uppercase;">Eficiencia del Sistema</span>
                            <div style="width: 24px; height: 24px; background: #fef3c7; border-radius: 6px; display: flex; align-items: center; justify-content: center;">
                                <span style="font-size: 10px; font-weight: 600; color: #f59e0b;"><%= eficienciaPorcentaje %>%</span>
                            </div>
                        </div>
                        <p style="font-size: 24px; font-weight: bold; color: #1e40af;"><%= eficienciaPorcentaje %>%</p>
                        <p style="font-size: 12px; color: #10b981;">Cumplimiento de plazos</p>
                    </div>

                    <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 20px;">
                        <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 12px;">
                            <span style="font-size: 12px; font-weight: 600; color: #6b7280; text-transform: uppercase;">Reportes Pendientes</span>
                            <div style="width: 24px; height: 24px; background: #fee2e2; border-radius: 6px; display: flex; align-items: center; justify-content: center;">
                                <span style="font-size: 10px; font-weight: 600; color: #ef4444;">3</span>
                            </div>
                        </div>
                        <p style="font-size: 24px; font-weight: bold; color: #1e40af;">3</p>
                        <p style="font-size: 12px; color: #ef4444;">Necesitan revisión</p>
                    </div>
                </div>

                <!-- Generador de Reportes -->
                <div style="background: #f8fafc; border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; margin-bottom: 32px;">
                    <h3 style="font-size: 18px; font-weight: 600; color: #1e40af; margin-bottom: 20px;">Generar Nuevo Reporte</h3>
                    
                    <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 24px;">
                        <!-- Reporte de Usuarios -->
                        <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 20px; cursor: pointer;" 
                             onclick="showReportModal('users')">
                            <div style="width: 48px; height: 48px; background: #dbeafe; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-bottom: 12px;">
                                <svg style="width: 24px; height: 24px; color: #3b82f6;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"/>
                                </svg>
                            </div>
                            <h4 style="font-size: 14px; font-weight: 600; color: #111827; margin-bottom: 4px;">Reporte de Usuarios</h4>
                            <p style="font-size: 12px; color: #6b7280;">Estudiantes y docentes del sistema</p>
                            <div style="display: flex; justify-content: space-between; margin-top: 12px;">
                                <span style="font-size: 11px; color: #6b7280;">PDF, Excel, CSV</span>
                                <svg style="width: 16px; height: 16px; color: #1e40af;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                                </svg>
                            </div>
                        </div>

                        <!-- Reporte de Tesis -->
                        <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 20px; cursor: pointer;"
                             onclick="showReportModal('thesis')">
                            <div style="width: 48px; height: 48px; background: #dbeafe; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-bottom: 12px;">
                                <svg style="width: 24px; height: 24px; color: #1e40af;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                </svg>
                            </div>
                            <h4 style="font-size: 14px; font-weight: 600; color: #111827; margin-bottom: 4px;">Reporte de Tesis</h4>
                            <p style="font-size: 12px; color: #6b7280;">Estado y estadísticas de tesis</p>
                            <div style="display: flex; justify-content: space-between; margin-top: 12px;">
                                <span style="font-size: 11px; color: #6b7280;">PDF, Excel, CSV</span>
                                <svg style="width: 16px; height: 16px; color: #1e40af;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                                </svg>
                            </div>
                        </div>

                        <!-- Reporte de Asignaciones -->
                        <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 20px; cursor: pointer;"
                             onclick="showReportModal('assignments')">
                            <div style="width: 48px; height: 48px; background: #ffedd5; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-bottom: 12px;">
                                <svg style="width: 24px; height: 24px; color: #f97316;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z"/>
                                </svg>
                            </div>
                            <h4 style="font-size: 14px; font-weight: 600; color: #111827; margin-bottom: 4px;">Reporte de Asignaciones</h4>
                            <p style="font-size: 12px; color: #6b7280;">Carga de trabajo de docentes</p>
                            <div style="display: flex; justify-content: space-between; margin-top: 12px;">
                                <span style="font-size: 11px; color: #6b7280;">PDF, Excel, CSV</span>
                                <svg style="width: 16px; height: 16px; color: #1e40af;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                                </svg>
                            </div>
                        </div>

                        <!-- Generar Certificado -->
                        <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 20px; cursor: pointer;"
                             onclick="showCertificateModal()">
                            <div style="width: 48px; height: 48px; background: #d1fae5; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-bottom: 12px;">
                                <svg style="width: 24px; height: 24px; color: #10b981;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                            </div>
                            <h4 style="font-size: 14px; font-weight: 600; color: #111827; margin-bottom: 4px;">Generar Certificado</h4>
                            <p style="font-size: 12px; color: #6b7280;">Certificado de aprobación de tesis</p>
                            <div style="display: flex; justify-content: space-between; margin-top: 12px;">
                                <span style="font-size: 11px; color: #6b7280;">PDF con sellos</span>
                                <svg style="width: 16px; height: 16px; color: #1e40af;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                                </svg>
                            </div>
                        </div>
                    </div>

                    <!-- Filtros avanzados -->
                    <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 20px; margin-bottom: 24px;">
                        <h4 style="font-size: 16px; font-weight: 600; color: #1e40af; margin-bottom: 16px;">Filtros Avanzados</h4>
                        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px;">
                            <div>
                                <label style="display: block; font-size: 12px; font-weight: 500; color: #374151; margin-bottom: 8px;">Rango de Fechas</label>
                                <div style="display: flex; gap: 8px;">
                                    <input type="date" id="fechaInicio" style="flex: 1; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;">
                                    <span style="align-self: center; color: #6b7280;">a</span>
                                    <input type="date" id="fechaFin" style="flex: 1; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;">
                                </div>
                            </div>
                            
                            <div>
                                <label style="display: block; font-size: 12px; font-weight: 500; color: #374151; margin-bottom: 8px;">Tipo de Reporte</label>
                                <select style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;">
                                    <option value="completo">Reporte Completo</option>
                                    <option value="resumen">Resumen Ejecutivo</option>
                                    <option value="detallado">Detallado</option>
                                    <option value="comparativo">Comparativo</option>
                                </select>
                            </div>
                            
                            <div>
                                <label style="display: block; font-size: 12px; font-weight: 500; color: #374151; margin-bottom: 8px;">Formato de Salida</label>
                                <div style="display: flex; gap: 8px;">
                                    <button style="flex: 1; padding: 8px; background: #1e40af; color: white; border-radius: 6px; font-size: 12px; font-weight: 500;">PDF</button>
                                    <button style="flex: 1; padding: 8px; background: #10b981; color: white; border-radius: 6px; font-size: 12px; font-weight: 500;">Excel</button>
                                    <button style="flex: 1; padding: 8px; background: #3b82f6; color: white; border-radius: 6px; font-size: 12px; font-weight: 500;">CSV</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Reportes Recientes -->
                <div style="margin-bottom: 32px;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                        <h3 style="font-size: 18px; font-weight: 600; color: #1e40af;">Reportes Generados Recientemente</h3>
                        <button style="padding: 8px 16px; background: #f8fafc; color: #1e40af; border: 1px solid #e5e7eb; border-radius: 6px; font-size: 12px; font-weight: 500;">
                            Ver todos los reportes
                        </button>
                    </div>

                    <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px;">
                        <table style="width: 100%; border-collapse: collapse;">
                            <thead style="background: #f9fafb;">
                                <tr>
                                    <th style="padding: 12px 16px; text-align: left; font-size: 11px; font-weight: 600; color: #6b7280; text-transform: uppercase;">ID Reporte</th>
                                    <th style="padding: 12px 16px; text-align: left; font-size: 11px; font-weight: 600; color: #6b7280; text-transform: uppercase;">Tipo</th>
                                    <th style="padding: 12px 16px; text-align: left; font-size: 11px; font-weight: 600; color: #6b7280; text-transform: uppercase;">Generado por</th>
                                    <th style="padding: 12px 16px; text-align: left; font-size: 11px; font-weight: 600; color: #6b7280; text-transform: uppercase;">Fecha</th>
                                    <th style="padding: 12px 16px; text-align: left; font-size: 11px; font-weight: 600; color: #6b7280; text-transform: uppercase;">Formato</th>
                                    <th style="padding: 12px 16px; text-align: left; font-size: 11px; font-weight: 600; color: #6b7280; text-transform: uppercase;">Tamaño</th>
                                    <th style="padding: 12px 16px; text-align: left; font-size: 11px; font-weight: 600; color: #6b7280; text-transform: uppercase;">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    // Simular reportes recientes
                                    String[][] reportesRecientes = {
                                        {"REP-2024-001", "Usuarios Activos", "Admin García", "15/11/2024", "PDF", "2.4 MB"},
                                        {"REP-2024-002", "Tesis Aprobadas", "Admin García", "14/11/2024", "Excel", "1.8 MB"},
                                        {"REP-2024-003", "Carga Docentes", "Admin García", "13/11/2024", "CSV", "850 KB"},
                                        {"CERT-2024-045", "Certificado", "Admin García", "12/11/2024", "PDF", "3.1 MB"},
                                        {"REP-2024-004", "Eficiencia Sistema", "Admin García", "11/11/2024", "PDF", "1.2 MB"}
                                    };
                                    
                                    for (String[] reporte : reportesRecientes) {
                                %>
                                <tr style="border-top: 1px solid #e5e7eb;">
                                    <td style="padding: 16px; font-size: 13px; font-weight: 600; color: #1e40af;">
                                        <%= reporte[0] %>
                                    </td>
                                    <td style="padding: 16px;">
                                        <span style="display: inline-flex; align-items: center; gap: 4px;">
                                            <%
                                                String icono = "";
                                                String color = "";
                                                if (reporte[1].contains("Certificado")) {
                                                    icono = "M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z";
                                                    color = "#10b981";
                                                } else if (reporte[1].contains("Usuarios")) {
                                                    icono = "M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z";
                                                    color = "#3b82f6";
                                                } else if (reporte[1].contains("Tesis")) {
                                                    icono = "M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z";
                                                    color = "#1e40af";
                                                } else {
                                                    icono = "M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z";
                                                    color = "#f97316";
                                                }
                                            %>
                                            <svg style="width: 14px; height: 14px; color: <%= color %>;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="<%= icono %>"/>
                                            </svg>
                                            <%= reporte[1] %>
                                        </span>
                                    </td>
                                    <td style="padding: 16px; font-size: 13px; color: #6b7280;"><%= reporte[2] %></td>
                                    <td style="padding: 16px; font-size: 13px; color: #6b7280;"><%= reporte[3] %></td>
                                    <td style="padding: 16px; font-size: 13px; color: #6b7280;">
                                        <span style="padding: 4px 8px; background: #f3f4f6; border-radius: 4px; font-size: 11px; font-weight: 500;">
                                            <%= reporte[4] %>
                                        </span>
                                    </td>
                                    <td style="padding: 16px; font-size: 13px; color: #6b7280;"><%= reporte[5] %></td>
                                    <td style="padding: 16px; font-size: 13px; font-weight: 500;">
                                        <button onclick="descargarReporte('<%= reporte[0] %>')" style="color: #1e40af; margin-right: 8px;">Descargar</button>
                                        <button onclick="verReporte('<%= reporte[0] %>')" style="color: #3b82f6;">Vista Previa</button>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Estadísticas Detalladas -->
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-bottom: 32px;">
                    <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px;">
                        <h4 style="font-size: 16px; font-weight: 600; color: #1e40af; margin-bottom: 16px;">Distribución de Tesis</h4>
                        <div style="height: 200px; display: flex; align-items: flex-end; gap: 16px; margin-bottom: 16px;">
                            <%
                                int[] distribucionTesis = {tesisSinAsignar, tesisEnRevision, tesisAprobadas, 5}; // 5 para rechazadas
                                String[] colores = {"#f59e0b", "#f97316", "#10b981", "#ef4444"};
                                String[] etiquetas = {"Sin Asignar", "En Revisión", "Aprobadas", "Rechazadas"};
                                
                                int maxValor = 0;
                                for (int valor : distribucionTesis) {
                                    if (valor > maxValor) maxValor = valor;
                                }
                                
                                for (int i = 0; i < distribucionTesis.length; i++) {
                                    int altura = maxValor > 0 ? (distribucionTesis[i] * 150) / maxValor : 0;
                            %>
                            <div style="display: flex; flex-direction: column; align-items: center; flex: 1;">
                                <div style="width: 30px; height: <%= altura %>px; background: <%= colores[i] %>; border-radius: 4px 4px 0 0;"></div>
                                <span style="margin-top: 8px; font-size: 12px; font-weight: 600; color: #374151;"><%= distribucionTesis[i] %></span>
                                <span style="margin-top: 4px; font-size: 10px; color: #6b7280;"><%= etiquetas[i] %></span>
                            </div>
                            <% } %>
                        </div>
                    </div>

                    <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px;">
                        <h4 style="font-size: 16px; font-weight: 600; color: #1e40af; margin-bottom: 16px;">Actividad del Sistema</h4>
                        <div style="display: grid; gap: 12px;">
                            <div>
                                <div style="display: flex; justify-content: space-between; margin-bottom: 4px;">
                                    <span style="font-size: 12px; color: #6b7280;">Usuarios activos hoy</span>
                                    <span style="font-size: 12px; font-weight: 600; color: #1e40af;">42</span>
                                </div>
                                <div style="height: 4px; background: #e5e7eb; border-radius: 2px;">
                                    <div style="width: 75%; height: 100%; background: #3b82f6; border-radius: 2px;"></div>
                                </div>
                            </div>
                            
                            <div>
                                <div style="display: flex; justify-content: space-between; margin-bottom: 4px;">
                                    <span style="font-size: 12px; color: #6b7280;">Tesis revisadas hoy</span>
                                    <span style="font-size: 12px; font-weight: 600; color: #1e40af;">8</span>
                                </div>
                                <div style="height: 4px; background: #e5e7eb; border-radius: 2px;">
                                    <div style="width: 40%; height: 100%; background: #10b981; border-radius: 2px;"></div>
                                </div>
                            </div>
                            
                            <div>
                                <div style="display: flex; justify-content: space-between; margin-bottom: 4px;">
                                    <span style="font-size: 12px; color: #6b7280;">Asignaciones pendientes</span>
                                    <span style="font-size: 12px; font-weight: 600; color: #1e40af;">5</span>
                                </div>
                                <div style="height: 4px; background: #e5e7eb; border-radius: 2px;">
                                    <div style="width: 25%; height: 100%; background: #f59e0b; border-radius: 2px;"></div>
                                </div>
                            </div>
                            
                            <div>
                                <div style="display: flex; justify-content: space-between; margin-bottom: 4px;">
                                    <span style="font-size: 12px; color: #6b7280;">Certificados emitidos</span>
                                    <span style="font-size: 12px; font-weight: 600; color: #1e40af;">3</span>
                                </div>
                                <div style="height: 4px; background: #e5e7eb; border-radius: 2px;">
                                    <div style="width: 15%; height: 100%; background: #1e40af; border-radius: 2px;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Exportar Datos -->
                <div style="background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px;">
                    <h4 style="font-size: 16px; font-weight: 600; color: #1e40af; margin-bottom: 16px;">Exportar Datos Completos</h4>
                    <p style="color: #6b7280; margin-bottom: 20px;">Exporte la base de datos completa en diferentes formatos</p>
                    
                    <div style="display: flex; gap: 12px;">
                        <button onclick="exportarDatos('completo', 'pdf')" style="flex: 1; padding: 16px; background: #1e40af; color: white; border-radius: 6px; font-weight: 600; font-size: 14px;">
                            <div style="display: flex; align-items: center; justify-content: center; gap: 8px;">
                                <svg style="width: 18px; height: 18px;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z"/>
                                </svg>
                                Exportar PDF Completo
                            </div>
                        </button>
                        
                        <button onclick="exportarDatos('completo', 'excel')" style="flex: 1; padding: 16px; background: #10b981; color: white; border-radius: 6px; font-weight: 600; font-size: 14px;">
                            <div style="display: flex; align-items: center; justify-content: center; gap: 8px;">
                                <svg style="width: 18px; height: 18px;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 17v-2m3 2v-4m3 4v-6m2 10H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                </svg>
                                Exportar Excel Completo
                            </div>
                        </button>
                        
                        <button onclick="exportarDatos('completo', 'csv')" style="flex: 1; padding: 16px; background: #3b82f6; color: white; border-radius: 6px; font-weight: 600; font-size: 14px;">
                            <div style="display: flex; align-items: center; justify-content: center; gap: 8px;">
                                <svg style="width: 18px; height: 18px;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"/>
                                </svg>
                                Exportar CSV Completo
                            </div>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal de Asignación -->
        <div id="assignModal" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); display: none; align-items: center; justify-content: center; z-index: 1000;">
            <div style="background: white; border-radius: 8px; padding: 24px; max-width: 500px; width: 90%;">
                <form id="assignForm" method="post" action="administrador.jsp">
                    <input type="hidden" name="action" value="assign_thesis">
                    <input type="hidden" name="tesis_id" id="tesisId">
                    
                    <h3 style="font-size: 18px; font-weight: 600; color: #1e40af; margin-bottom: 16px;">Asignar Evaluador</h3>
                    
                    <div style="display: grid; gap: 16px;">
                        <div>
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Estudiante</label>
                            <input type="text" id="studentName" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb;" readonly>
                        </div>
                        
                        <div>
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Área de Estudio</label>
                            <input type="text" id="studyArea" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb;" readonly>
                        </div>
                        
                        <div>
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Docente Evaluador *</label>
                            <select name="docente_id" id="teacherSelect" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;" required>
                                <option value="">Seleccionar docente...</option>
                                <%
                                    
                                    try {
                                        connDoc3 = DatabaseConnection.getConnection();
                                        String sql = "SELECT d.id, CONCAT(d.titulo, ' ', u.nombre, ' ', u.apellido) as nombre_completo, " +
                                                   "d.especialidad, d.tesis_asignadas, d.capacidad_maxima " +
                                                   "FROM docentes d " +
                                                   "JOIN usuarios u ON d.id = u.id " +
                                                   "WHERE u.estado = 'ACTIVO' " +
                                                   "ORDER BY d.carga_trabajo ASC, d.especialidad";
                                        pstmtDoc3 = connDoc3.prepareStatement(sql);
                                        rsDoc3 = pstmtDoc3.executeQuery();
                                        
                                        while (rsDoc3.next()) {
                                            String texto = rsDoc3.getString("nombre_completo") + " (" + 
                                                          rsDoc3.getString("especialidad") + ") - " + 
                                                          rsDoc3.getInt("tesis_asignadas") + " tesis";
                                %>
                                <option value="<%= rsDoc3.getInt("id") %>"><%= texto %></option>
                                <%
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        if (rsDoc3 != null) try { rsDoc3.close(); } catch (Exception e) {}
                                        if (pstmtDoc3 != null) try { pstmtDoc3.close(); } catch (Exception e) {}
                                        if (connDoc3 != null) try { connDoc3.close(); } catch (Exception e) {}
                                    }
                                %>
                            </select>
                        </div>
                        
                        <div>
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Fecha Límite *</label>
                            <input type="date" name="fecha_limite" id="fechaLimite" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;" required>
                        </div>
                        
                        <div style="display: flex; gap: 12px; margin-top: 16px;">
                            <button type="submit" style="flex: 1; background: #1e40af; color: white; padding: 12px; border-radius: 6px; font-weight: 600;">Asignar</button>
                            <button type="button" onclick="closeAssignModal()" style="flex: 1; background: #6b7280; color: white; padding: 12px; border-radius: 6px; font-weight: 600;">Cancelar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modal de Crear Usuario -->
        <div id="createUserModal" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); display: none; align-items: center; justify-content: center; z-index: 1000;">
            <div style="background: white; border-radius: 8px; padding: 24px; max-width: 500px; width: 90%;">
                <form id="createUserForm" method="post" action="administrador.jsp">
                    <input type="hidden" name="action" value="create_user">
                    <input type="hidden" name="tipo_usuario" id="tipoUsuario">
                    
                    <h3 id="createUserTitle" style="font-size: 18px; font-weight: 600; color: #1e40af; margin-bottom: 16px;">Crear Nuevo Usuario</h3>
                    
                    <div style="display: grid; gap: 16px;">
                        <div>
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Nombre *</label>
                            <input type="text" name="nombre" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;" placeholder="Nombre" required>
                        </div>
                        
                        <div>
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Apellido *</label>
                            <input type="text" name="apellido" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;" placeholder="Apellido" required>
                        </div>
                        
                        <div>
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Email Institucional *</label>
                            <input type="email" name="email" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;" placeholder="usuario@universidad.es" required>
                        </div>
                        
                        <div>
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Contraseña *</label>
                            <input type="password" name="password" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;" placeholder="********" required>
                        </div>
                        
                        <div id="studentFields" style="display: none;">
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Código de Estudiante *</label>
                            <input type="text" name="codigo_estudiante" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;" placeholder="Ej: 2023001">
                            
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-top: 16px; margin-bottom: 8px;">Carrera *</label>
                            <select name="carrera_id" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;">
                                <option value="">Seleccionar carrera...</option>
                                <%
                                    Connection connCar = null;
                                    PreparedStatement pstmtCar = null;
                                    ResultSet rsCar = null;
                                    
                                    try {
                                        connCar = DatabaseConnection.getConnection();
                                        String sql = "SELECT id, nombre FROM carreras WHERE activa = TRUE";
                                        pstmtCar = connCar.prepareStatement(sql);
                                        rsCar = pstmtCar.executeQuery();
                                        
                                        while (rsCar.next()) {
                                %>
                                <option value="<%= rsCar.getInt("id") %>"><%= rsCar.getString("nombre") %></option>
                                <%
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        if (rsCar != null) try { rsCar.close(); } catch (Exception e) {}
                                        if (pstmtCar != null) try { pstmtCar.close(); } catch (Exception e) {}
                                        if (connCar != null) try { connCar.close(); } catch (Exception e) {}
                                    }
                                %>
                            </select>
                        </div>
                        
                        <div id="teacherFields" style="display: none;">
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Especialidad *</label>
                            <input type="text" name="especialidad" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;" placeholder="Ej: Ingeniería, Medicina, etc.">
                            
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-top: 16px; margin-bottom: 8px;">Título *</label>
                            <select name="titulo" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;">
                                <option value="Prof.">Prof.</option>
                                <option value="Dr.">Dr.</option>
                                <option value="Dra.">Dra.</option>
                                <option value="Mg.">Mg.</option>
                            </select>
                            
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-top: 16px; margin-bottom: 8px;">Capacidad Máxima *</label>
                            <input type="number" name="capacidad_maxima" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px;" value="5" min="1" max="10">
                        </div>
                        
                        <div style="display: flex; gap: 12px; margin-top: 16px;">
                            <button type="submit" style="flex: 1; background: #1e40af; color: white; padding: 12px; border-radius: 6px; font-weight: 600;">Crear Usuario</button>
                            <button type="button" onclick="closeCreateUserModal()" style="flex: 1; background: #6b7280; color: white; padding: 12px; border-radius: 6px; font-weight: 600;">Cancelar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>                    

        <!-- Modal de Detalles de Usuario -->
<div id="userDetailModal" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); display: none; align-items: center; justify-content: center; z-index: 1000;">
    <div style="background: white; border-radius: 8px; padding: 24px; max-width: 600px; width: 90%; max-height: 90vh; overflow-y: auto;">
        <form id="userDetailForm" method="post" action="administrador.jsp">
            <input type="hidden" name="action" value="delete\_user">
            <input type="hidden" name="usuario\_id" id="detailUsuarioId">
            <input type="hidden" name="tipo\_usuario" id="detailTipoUsuario">
 
            <!-- Encabezado con icono de tipo de usuario -->
            <div style="display: flex; align-items: center; margin-bottom: 24px;">
                <div id="detailUserIcon" style="width: 48px; height: 48px; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-right: 16px; font-size: 20px;">
                    <!-- Icono se llenará dinámicamente -->
                </div>
                <div style="flex: 1;">
                    <h3 id="detailUserName" style="font-size: 18px; font-weight: 600; color: #1e40af; margin-bottom: 4px;"></h3>
                    <p id="detailUserEmail" style="font-size: 14px; color: #6b7280;"></p>
                </div>
                <span id="detailUserBadge" style="padding: 6px 12px; border-radius: 9999px; font-size: 12px; font-weight: 500;">
                    <!-- Tipo de usuario se llenará dinámicamente -->
                </span>
            </div>

            <!-- Información general -->
            <div style="margin-bottom: 24px;">
                <h4 style="font-size: 16px; font-weight: 600; color: #374151; margin-bottom: 16px; border-bottom: 1px solid #e5e7eb; padding-bottom: 8px;">
                    Información General
                </h4>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                    <div>
                        <label style="display: block; font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px; text-transform: uppercase;">Nombre</label>
                        <input type="text" id="detailNombre" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb; font-size: 14px;" readonly>
                    </div>
 
                    <div>
                        <label style="display: block; font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px; text-transform: uppercase;">Apellido</label>
                        <input type="text" id="detailApellido" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb; font-size: 14px;" readonly>
                    </div>
 
                    <div>
                        <label style="display: block; font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px; text-transform: uppercase;">Email</label>
                        <input type="text" id="detailEmail" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb; font-size: 14px;" readonly>
                    </div>
 
                    <div>
                        <label style="display: block; font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px; text-transform: uppercase;">Estado</label>
                        <input type="text" id="detailEstado" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb; font-size: 14px;" readonly>
                    </div>
 
                    <div>
                        <label style="display: block; font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px; text-transform: uppercase;">Fecha Creación</label>
                        <input type="text" id="detailFechaCreacion" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb; font-size: 14px;" readonly>
                    </div>
 
                    <div>
                        <label style="display: block; font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px; text-transform: uppercase;">Última Modificación</label>
                        <input type="text" id="detailFechaModificacion" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb; font-size: 14px;" readonly>
                    </div>
                </div>
            </div>

            <!-- Información específica según tipo -->
            <div id="detailStudentFields" style="margin-bottom: 24px; display: none;">
                <h4 style="font-size: 16px; font-weight: 600; color: #374151; margin-bottom: 16px; border-bottom: 1px solid #e5e7eb; padding-bottom: 8px;">
                    Información de Estudiante
                </h4>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                    <div>
                        <label style="display: block; font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px; text-transform: uppercase;">Código Estudiante</label>
                        <input type="text" id="detailCodigoEstudiante" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb; font-size: 14px;" readonly>
                    </div>
 
                    <div>
                        <label style="display: block; font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px; text-transform: uppercase;">Carrera</label>
                        <input type="text" id="detailCarrera" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb; font-size: 14px;" readonly>
                    </div>
 
                    <div>
                        <label style="display: block; font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px; text-transform: uppercase;">Estado Tesis</label>
                        <input type="text" id="detailEstadoTesis" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb; font-size: 14px;" readonly>
                    </div>
 
                    <div>
                        <label style="display: block; font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px; text-transform: uppercase;">Tesis Asignadas</label>
                        <input type="text" id="detailTesisAsignadas" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb; font-size: 14px;" readonly>
                    </div>
                </div>
            </div>

            <div id="detailTeacherFields" style="margin-bottom: 24px; display: none;">
                <h4 style="font-size: 16px; font-weight: 600; color: #374151; margin-bottom: 16px; border-bottom: 1px solid #e5e7eb; padding-bottom: 8px;">
                    Información de Docente
                </h4>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                    <div>
                        <label style="display: block; font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px; text-transform: uppercase;">Especialidad</label>
                        <input type="text" id="detailEspecialidad" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb; font-size: 14px;" readonly>
                    </div>
 
                    <div>
                        <label style="display: block; font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px; text-transform: uppercase;">Título</label>
                        <input type="text" id="detailTitulo" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb; font-size: 14px;" readonly>
                    </div>
 
                    <div>
                        <label style="display: block; font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px; text-transform: uppercase;">Capacidad Máxima</label>
                        <input type="text" id="detailCapacidadMaxima" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb; font-size: 14px;" readonly>
                    </div>
 
                    <div>
                        <label style="display: block; font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px; text-transform: uppercase;">Tesis Asignadas</label>
                        <input type="text" id="detailTesisDocente" style="width: 100%; padding: 8px 12px; border: 1px solid #e5e7eb; border-radius: 6px; background: #f9fafb; font-size: 14px;" readonly>
                    </div>
 
                    <div>
                        <label style="display: block; font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px; text-transform: uppercase;">Carga de Trabajo</label>
                        <div style="display: flex; align-items: center; gap: 8px;">
                            <div style="flex: 1; height: 8px; background: #e5e7eb; border-radius: 4px; overflow: hidden;">
                                <div id="detailCargaTrabajoBar" style="height: 100%; width: 0%; background: #f97316; border-radius: 4px;"></div>
                            </div>
                            <span id="detailCargaTrabajo" style="font-size: 12px; font-weight: 600;">0%</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Estadísticas adicionales -->
            <div style="margin-bottom: 32px;">
                <h4 style="font-size: 16px; font-weight: 600; color: #374151; margin-bottom: 16px; border-bottom: 1px solid #e5e7eb; padding-bottom: 8px;">
                    Estadísticas
                </h4>
                <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px;">
                    <div style="text-align: center; padding: 12px; background: #f8fafc; border-radius: 6px; border: 1px solid #e5e7eb;">
                        <p style="font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px;">Actividad</p>
                        <p id="detailActividad" style="font-size: 16px; font-weight: 600; color: #1e40af;">-</p>
                    </div>
 
                    <div style="text-align: center; padding: 12px; background: #f8fafc; border-radius: 6px; border: 1px solid #e5e7eb;">
                        <p style="font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px;">Sesiones</p>
                        <p id="detailSesiones" style="font-size: 16px; font-weight: 600; color: #1e40af;">-</p>
                    </div>
 
                    <div style="text-align: center; padding: 12px; background: #f8fafc; border-radius: 6px; border: 1px solid #e5e7eb;">
                        <p style="font-size: 12px; font-weight: 500; color: #6b7280; margin-bottom: 4px;">Último Acceso</p>
                        <p id="detailUltimoAcceso" style="font-size: 12px; font-weight: 600; color: #1e40af;">-</p>
                    </div>
                </div>
            </div>

            <!-- Botones de acción -->
            <div style="display: flex; gap: 12px; margin-top: 24px; border-top: 1px solid #e5e7eb; padding-top: 24px;">
                <button type="button" onclick="closeUserDetailModal()" style="flex: 1; background: #6b7280; color: white; padding: 12px; border-radius: 6px; font-weight: 600; font-size: 14px;">
                    Cerrar
                </button>
                <button type="button" onclick="editarUsuario()" id="editButton" style="flex: 1; background: #3b82f6; color: white; padding: 12px; border-radius: 6px; font-weight: 600; font-size: 14px;">
                    Editar Usuario
                </button>
                <button type="button" onclick="confirmarEliminacion()" id="deleteButton" style="flex: 1; background: #ef4444; color: white; padding: 12px; border-radius: 6px; font-weight: 600; font-size: 14px;">
                    Eliminar Usuario
                </button>
            </div>
        </form>
    </div>
</div>



        <!-- Modal para Generar Reporte -->
        <div id="reportModal" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); display: none; align-items: center; justify-content: center; z-index: 1000;">
            <div style="background: white; border-radius: 8px; padding: 32px; max-width: 600px; width: 90%; max-height: 90vh; overflow-y: auto;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px;">
                    <h3 id="reportModalTitle" style="font-size: 18px; font-weight: 600; color: #1e40af;">Generar Reporte</h3>
                    <button onclick="closeReportModal()" style="color: #6b7280; background: none; border: none;">
                        <svg style="width: 20px; height: 20px;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                        </svg>
                    </button>
                </div>

                <form id="reportForm" method="post" action="ReportesController" target="_blank">
                    <input type="hidden" name="action" value="generate_report">
                    <input type="hidden" name="report_type" id="reportType">
                    
                    <div style="display: grid; gap: 20px;">
                        <div>
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Nombre del Reporte</label>
                            <input type="text" name="report_name" id="reportName" style="width: 100%; padding: 10px 12px; border: 1px solid #e5e7eb; border-radius: 6px;" 
                                   placeholder="Ej: Reporte de Usuarios - Noviembre 2024" required>
                        </div>
                        
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                            <div>
                                <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Formato</label>
                                <select name="format" id="reportFormat" style="width: 100%; padding: 10px 12px; border: 1px solid #e5e7eb; border-radius: 6px;" required>
                                    <option value="pdf">PDF (Recomendado)</option>
                                    <option value="excel">Excel (.xlsx)</option>
                                    <option value="csv">CSV (.csv)</option>
                                    <option value="html">HTML</option>
                                </select>
                            </div>
                            
                            <div>
                                <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Detalle</label>
                                <select name="detail_level" style="width: 100%; padding: 10px 12px; border: 1px solid #e5e7eb; border-radius: 6px;">
                                    <option value="summary">Resumen</option>
                                    <option value="detailed" selected>Detallado</option>
                                    <option value="complete">Completo</option>
                                </select>
                            </div>
                        </div>
                        
                        <div id="certificateSpecificFields" style="display: none;">
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Seleccionar Tesis para Certificado</label>
                            <select name="thesis_id" style="width: 100%; padding: 10px 12px; border: 1px solid #e5e7eb; border-radius: 6px;">
                                <option value="">Seleccionar tesis aprobada...</option>
                                <%
                                    Connection connCert = null;
                                    PreparedStatement pstmtCert = null;
                                    ResultSet rsCert = null;
                                    
                                    try {
                                        connCert = DatabaseConnection.getConnection();
                                        String sql = "SELECT t.id, t.titulo, CONCAT(u.nombre, ' ', u.apellido) as estudiante " +
                                                   "FROM tesis t " +
                                                   "JOIN estudiantes e ON t.estudiante_id = e.id " +
                                                   "JOIN usuarios u ON e.id = u.id " +
                                                   "WHERE t.estado = 'APROBADA' " +
                                                   "ORDER BY t.fecha_aprobacion DESC";
                                        
                                        pstmtCert = connCert.prepareStatement(sql);
                                        rsCert = pstmtCert.executeQuery();
                                        
                                        while (rsCert.next()) {
                                %>
                                <option value="<%= rsCert.getInt("id") %>">
                                    <%= rsCert.getString("estudiante") %> - <%= rsCert.getString("titulo").length() > 50 ? 
                                        rsCert.getString("titulo").substring(0, 50) + "..." : rsCert.getString("titulo") %>
                                </option>
                                <%
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        if (rsCert != null) try { rsCert.close(); } catch (Exception e) {}
                                        if (pstmtCert != null) try { pstmtCert.close(); } catch (Exception e) {}
                                        if (connCert != null) try { connCert.close(); } catch (Exception e) {}
                                    }
                                %>
                            </select>
                        </div>
                        
                        <div>
                            <label style="display: block; font-size: 14px; font-weight: 500; color: #374151; margin-bottom: 8px;">Comentarios (Opcional)</label>
                            <textarea name="comments" style="width: 100%; padding: 10px 12px; border: 1px solid #e5e7eb; border-radius: 6px; min-height: 60px;" 
                                      placeholder="Notas adicionales para incluir en el reporte..."></textarea>
                        </div>
                        
                        <div style="display: flex; gap: 12px; padding-top: 20px; border-top: 1px solid #e5e7eb;">
                            <button type="submit" style="flex: 2; background: #1e40af; color: white; padding: 12px; border-radius: 6px; font-weight: 600; font-size: 14px;">
                                Generar y Descargar
                            </button>
                            <button type="button" onclick="closeReportModal()" style="flex: 1; background: #6b7280; color: white; padding: 12px; border-radius: 6px; font-weight: 600; font-size: 14px;">
                                Cancelar
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modal de confirmación de eliminación -->
        <div id="confirmDeleteModal" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); display: none; align-items: center; justify-content: center; z-index: 1100;">
            <div style="background: white; border-radius: 8px; padding: 24px; max-width: 400px; width: 90%;">
                <div style="text-align: center; margin-bottom: 24px;">
                    <div style="width: 60px; height: 60px; background: #fee2e2; border-radius: 9999px; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px;">
                        <svg style="width: 24px; height: 24px; color: #ef4444;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                        </svg>
                    </div>
                    <h3 style="font-size: 18px; font-weight: 600; color: #374151; margin-bottom: 8px;">¿Eliminar Usuario?</h3>
                    <p id="deleteMessage" style="font-size: 14px; color: #6b7280;">
                        Esta acción eliminará permanentemente al usuario y todos sus datos asociados.
                    </p>
                </div>
                
                <div style="display: flex; gap: 12px;">
                    <button type="button" onclick="closeConfirmDeleteModal()" style="flex: 1; background: #6b7280; color: white; padding: 12px; border-radius: 6px; font-weight: 600;">
                        Cancelar
                    </button>
                    <button type="button" onclick="eliminarUsuario()" style="flex: 1; background: #ef4444; color: white; padding: 12px; border-radius: 6px; font-weight: 600;">
                        Sí, Eliminar
                    </button>
                </div>
            </div>
        </div>
    </main>

    <script>
        // ============= FUNCIONES PRINCIPALES DE NAVEGACIÓN =============
function showSection(sectionId) {
    // Ocultar todas las secciones
    document.querySelectorAll('.section').forEach(section => {
        section.classList.remove('active');
    });
    
    // Mostrar la sección seleccionada
    const activeSection = document.getElementById(sectionId);
    if (activeSection) {
        activeSection.classList.add('active');
    }
    
    // Actualizar el estado activo en el menú
    document.querySelectorAll('.nav-btn').forEach(btn => {
        btn.classList.remove('active');
        if (btn.dataset.section === sectionId) {
            btn.classList.add('active');
        }
    });
    
    // Scroll to top suave
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

// ============= FUNCIONES PARA PESTAÑAS DE USUARIOS =============
function showUserTab(tab) {
    const studentsTab = document.getElementById('studentsTab');
    const teachersTab = document.getElementById('teachersTab');
    const studentsTable = document.getElementById('studentsTable');
    const teachersTable = document.getElementById('teachersTable');

    if (tab === 'students') {
        studentsTab.style.borderBottom = '2px solid #1e40af';
        studentsTab.style.color = '#1e40af';
        studentsTab.style.fontWeight = '500';
        teachersTab.style.borderBottom = '2px solid transparent';
        teachersTab.style.color = '#6b7280';
        teachersTab.style.fontWeight = '400';
        studentsTable.style.display = 'block';
        teachersTable.style.display = 'none';
    } else {
        teachersTab.style.borderBottom = '2px solid #1e40af';
        teachersTab.style.color = '#1e40af';
        teachersTab.style.fontWeight = '500';
        studentsTab.style.borderBottom = '2px solid transparent';
        studentsTab.style.color = '#6b7280';
        studentsTab.style.fontWeight = '400';
        teachersTable.style.display = 'block';
        studentsTable.style.display = 'none';
    }
}

// ============= FUNCIONES PARA REPORTES =============
function showReportModal(reportType) {
    const modal = document.getElementById('reportModal');
    const title = document.getElementById('reportModalTitle');
    const reportTypeInput = document.getElementById('reportType');
    const reportName = document.getElementById('reportName');
    
    // Ocultar todos los campos específicos primero
    document.getElementById('certificateSpecificFields').style.display = 'none';
    
    // Configurar según el tipo de reporte
    let reportTitle = '';
    let defaultFormat = 'pdf';
    
    switch(reportType) {
        case 'users':
            reportTitle = 'Generar Reporte de Usuarios';
            reportName.value = 'Reporte de Usuarios - ' + new Date().toLocaleDateString();
            defaultFormat = 'excel';
            break;
            
        case 'thesis':
            reportTitle = 'Generar Reporte de Tesis';
            reportName.value = 'Reporte de Tesis - ' + new Date().toLocaleDateString();
            break;
            
        case 'assignments':
            reportTitle = 'Generar Reporte de Asignaciones';
            reportName.value = 'Reporte de Asignaciones - ' + new Date().toLocaleDateString();
            defaultFormat = 'csv';
            break;
            
        case 'certificate':
            reportTitle = 'Generar Certificado de Aprobación';
            reportName.value = 'Certificado de Aprobación';
            defaultFormat = 'pdf';
            document.getElementById('certificateSpecificFields').style.display = 'block';
            break;
    }
    
    title.textContent = reportTitle;
    reportTypeInput.value = reportType;
    document.getElementById('reportFormat').value = defaultFormat;
    modal.style.display = 'flex';
}

function showCertificateModal() {
    showReportModal('certificate');
}

function closeReportModal() {
    document.getElementById('reportModal').style.display = 'none';
}

function descargarReporte(reportId) {
    alert('Descargando reporte: ' + reportId);
}

function exportarDatos(tipo, formato) {
    let mensaje = '';
    
    switch(formato) {
        case 'pdf':
            mensaje = 'Exportando base de datos completa en formato PDF. Esto puede tomar unos momentos...';
            break;
        case 'excel':
            mensaje = 'Exportando base de datos completa en formato Excel. Esto puede tomar unos momentos...';
            break;
        case 'csv':
            mensaje = 'Exportando base de datos completa en formato CSV. Esto puede tomar unos momentos...';
            break;
    }
    
    if (confirm(mensaje)) {
        setTimeout(() => {
            alert('Exportación completada exitosamente. El archivo comenzará a descargarse.');
        }, 1500);
    }
}

// ============= FUNCIONES PARA TESIS =============
function filtrarTesis(filtro) {
    const filas = document.querySelectorAll('#tablaTesis tr');
    filas.forEach(fila => {
        const estado = fila.getAttribute('data-estado');
        let mostrar = false;
        
        switch(filtro) {
            case 'todas':
                mostrar = true;
                break;
            case 'sin_asignar':
                mostrar = estado === 'sin_enviar' || estado === 'borrador';
                break;
            case 'en_revision':
                mostrar = estado === 'en_revision';
                break;
            case 'aprobadas':
                mostrar = estado === 'aprobada';
                break;
            case 'rechazadas':
                mostrar = estado === 'rechazada';
                break;
            default:
                mostrar = true;
        }
        
        fila.style.display = mostrar ? '' : 'none';
    });
}

function showAssignModal(studentName, area, tesisId) {
    document.getElementById('studentName').value = studentName;
    document.getElementById('studyArea').value = area;
    document.getElementById('tesisId').value = tesisId;
    
    const hoy = new Date();
    const fechaLimite = new Date(hoy.getTime() + 30 * 24 * 60 * 60 * 1000);
    document.getElementById('fechaLimite').value = fechaLimite.toISOString().split('T')[0];
    
    document.getElementById('assignModal').style.display = 'flex';
}

function closeAssignModal() {
    document.getElementById('assignModal').style.display = 'none';
}

// ============= FUNCIONES PARA USUARIOS =============
function showCreateUserModal(userType) {
    const tipoUsuario = document.getElementById('tipoUsuario');
    const studentFields = document.getElementById('studentFields');
    const teacherFields = document.getElementById('teacherFields');
    const title = document.getElementById('createUserTitle');
    
    tipoUsuario.value = userType.toUpperCase();
    
    if (userType === 'student') {
        title.textContent = 'Crear Nuevo Estudiante';
        studentFields.style.display = 'block';
        teacherFields.style.display = 'none';
    } else {
        title.textContent = 'Crear Nuevo Docente';
        teacherFields.style.display = 'block';
        studentFields.style.display = 'none';
    }
    
    document.getElementById('createUserModal').style.display = 'flex';
}

function closeCreateUserModal() {
    document.getElementById('createUserModal').style.display = 'none';
}

// ============= FUNCIONES PARA DETALLES DE USUARIO =============
function showUserDetailModal(userId, tipo, nombre, apellido, email, estado) {
    // Limpiar campos previos
    resetDetailModal();
    
    // Establecer valores básicos
    document.getElementById('detailUsuarioId').value = userId;
    document.getElementById('detailTipoUsuario').value = tipo;
    document.getElementById('detailNombre').value = nombre || '';
    document.getElementById('detailApellido').value = apellido || '';
    document.getElementById('detailEmail').value = email || '';
    document.getElementById('detailEstado').value = estado || 'ACTIVO';
    
    // Configurar nombre completo y email
    document.getElementById('detailUserName').textContent = (nombre + ' ' + apellido).trim();
    document.getElementById('detailUserEmail').textContent = email || '';
    
    // Configurar icono y badge según tipo
    const userIcon = document.getElementById('detailUserIcon');
    const userBadge = document.getElementById('detailUserBadge');
    
    if (tipo === 'ESTUDIANTE' || tipo === 'EST') {
        userIcon.innerHTML = '<svg style="width: 24px; height: 24px; color: #3b82f6;" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"/></svg>';
        userIcon.style.backgroundColor = '#dbeafe';
        userBadge.textContent = 'ESTUDIANTE';
        userBadge.style.backgroundColor = '#dbeafe';
        userBadge.style.color = '#1e40af';
        
        // Mostrar campos de estudiante
        document.getElementById('detailStudentFields').style.display = 'block';
        document.getElementById('detailTeacherFields').style.display = 'none';
        
        // Obtener detalles específicos del estudiante
        cargarDetallesEstudiante(userId);
        
    } else if (tipo === 'DOCENTE' || tipo === 'DOC') {
        userIcon.innerHTML = '<svg style="width: 24px; height: 24px; color: #f97316;" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z"/></svg>';
        userIcon.style.backgroundColor = '#ffedd5';
        userBadge.textContent = 'DOCENTE';
        userBadge.style.backgroundColor = '#ffedd5';
        userBadge.style.color = '#9a3412';
        
        // Mostrar campos de docente
        document.getElementById('detailTeacherFields').style.display = 'block';
        document.getElementById('detailStudentFields').style.display = 'none';
        
        // Obtener detalles específicos del docente
        cargarDetallesDocente(userId);
    } else {
        userIcon.innerHTML = '<svg style="width: 24px; height: 24px; color: #1e40af;" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/></svg>';
        userIcon.style.backgroundColor = '#e0e7ff';
        userBadge.textContent = tipo || 'USUARIO';
        userBadge.style.backgroundColor = '#e0e7ff';
        userBadge.style.color = '#1e40af';
    }
    
    // Mostrar la modal
    document.getElementById('userDetailModal').style.display = 'flex';
    
    // Cargar detalles adicionales
    cargarDetallesUsuario(userId);
}

function cargarDetallesUsuario(userId) {
    // Aquí puedes hacer una petición AJAX para obtener más detalles
    // Por ahora, simularemos algunos datos
    
    // Fechas (simuladas)
    const ahora = new Date();
    const fechaCreacion = new Date(ahora.getTime() - Math.random() * 30 * 24 * 60 * 60 * 1000);
    const fechaModificacion = new Date(ahora.getTime() - Math.random() * 7 * 24 * 60 * 60 * 1000);
    const ultimoAcceso = new Date(ahora.getTime() - Math.random() * 24 * 60 * 60 * 1000);
    
    document.getElementById('detailFechaCreacion').value = fechaCreacion.toLocaleDateString();
    document.getElementById('detailFechaModificacion').value = fechaModificacion.toLocaleDateString();
    document.getElementById('detailUltimoAcceso').textContent = ultimoAcceso.toLocaleString();
    
    // Estadísticas (simuladas)
    document.getElementById('detailActividad').textContent = 'Alta';
    document.getElementById('detailSesiones').textContent = Math.floor(Math.random() * 50) + 10;
}

function cargarDetallesEstudiante(estudianteId) {
    // Simular datos del estudiante
    document.getElementById('detailCodigoEstudiante').value = '2023' + String(estudianteId).padStart(3, '0');
    document.getElementById('detailCarrera').value = 'Ingeniería de Sistemas';
    document.getElementById('detailEstadoTesis').value = Math.random() > 0.5 ? 'EN REVISIÓN' : 'SIN ENVIAR';
    document.getElementById('detailTesisAsignadas').value = Math.floor(Math.random() * 3);
    
    // Si tienes una API, aquí harías la petición AJAX:
    /*
    fetch('obtenerEstudiante.php?id=' + estudianteId)
        .then(response => response.json())
        .then(data => {
            document.getElementById('detailCodigoEstudiante').value = data.codigo_estudiante || '';
            document.getElementById('detailCarrera').value = data.carrera_nombre || '';
            document.getElementById('detailEstadoTesis').value = data.estado_tesis || '';
            document.getElementById('detailTesisAsignadas').value = data.tesis_count || 0;
        });
    */
}

function cargarDetallesDocente(docenteId) {
    // Simular datos del docente
    const capacidad = Math.floor(Math.random() * 5) + 3;
    const asignadas = Math.floor(Math.random() * capacidad);
    const carga = Math.round((asignadas / capacidad) * 100);
    
    document.getElementById('detailEspecialidad').value = 'Ingeniería de Software';
    document.getElementById('detailTitulo').value = 'Dr.';
    document.getElementById('detailCapacidadMaxima').value = capacidad;
    document.getElementById('detailTesisDocente').value = `${asignadas}/${capacidad}`;
    document.getElementById('detailCargaTrabajo').textContent = `${carga}%`;
    document.getElementById('detailCargaTrabajoBar').style.width = `${carga}%`;
    
    // Cambiar color según carga
    const bar = document.getElementById('detailCargaTrabajoBar');
    if (carga >= 90) {
        bar.style.backgroundColor = '#ef4444';
    } else if (carga >= 70) {
        bar.style.backgroundColor = '#f59e0b';
    } else {
        bar.style.backgroundColor = '#10b981';
    }
    
    // Si tienes una API, aquí harías la petición AJAX:
    /*
    fetch('obtenerDocente.php?id=' + docenteId)
        .then(response => response.json())
        .then(data => {
            document.getElementById('detailEspecialidad').value = data.especialidad || '';
            document.getElementById('detailTitulo').value = data.titulo || '';
            document.getElementById('detailCapacidadMaxima').value = data.capacidad_maxima || 0;
            document.getElementById('detailTesisDocente').value = data.tesis_asignadas + '/' + data.capacidad_maxima;
            
            const carga = data.carga_trabajo || 0;
            document.getElementById('detailCargaTrabajo').textContent = carga + '%';
            document.getElementById('detailCargaTrabajoBar').style.width = carga + '%';
        });
    */
}

function closeUserDetailModal() {
    document.getElementById('userDetailModal').style.display = 'none';
}

function resetDetailModal() {
    // Limpiar todos los campos
    const inputs = document.querySelectorAll('#userDetailModal input[type="text"]');
    inputs.forEach(input => input.value = '');
    
    // Ocultar secciones específicas
    document.getElementById('detailStudentFields').style.display = 'none';
    document.getElementById('detailTeacherFields').style.display = 'none';
    
    // Resetear barra de progreso
    document.getElementById('detailCargaTrabajoBar').style.width = '0%';
    document.getElementById('detailCargaTrabajo').textContent = '0%';
}

// ============= FUNCIONES PARA ELIMINACIÓN =============
function confirmarEliminacion() {
    const userId = document.getElementById('detailUsuarioId').value;
    const tipo = document.getElementById('detailTipoUsuario').value;
    const nombre = document.getElementById('detailNombre').value;
    const apellido = document.getElementById('detailApellido').value;
    
    // Configurar mensaje de confirmación
    const nombreCompleto = (nombre + ' ' + apellido).trim();
    let tipoTexto = 'usuario';
    if (tipo === 'ESTUDIANTE' || tipo === 'EST') tipoTexto = 'estudiante';
    if (tipo === 'DOCENTE' || tipo === 'DOC') tipoTexto = 'docente';
    
    document.getElementById('deleteMessage').innerHTML = 
        `¿Está seguro de eliminar al ${tipoTexto} <strong>${nombreCompleto}</strong>?<br>
        Esta acción eliminará permanentemente al usuario y todos sus datos asociados.`;
    
    // Mostrar modal de confirmación
    document.getElementById('confirmDeleteModal').style.display = 'flex';
}

function closeConfirmDeleteModal() {
    document.getElementById('confirmDeleteModal').style.display = 'none';
}

function eliminarUsuario() {
    const userId = document.getElementById('detailUsuarioId').value;
    const tipo = document.getElementById('detailTipoUsuario').value;
    
    // Enviar formulario para eliminar
    document.getElementById('userDetailForm').submit();
    
    // Cerrar modales
    closeConfirmDeleteModal();
    closeUserDetailModal();
}

function editarUsuario() {
    const userId = document.getElementById('detailUsuarioId').value;
    const tipo = document.getElementById('detailTipoUsuario').value;
    
    // Redirigir a página de edición o mostrar modal de edición
    alert('Funcionalidad de edición en desarrollo. ID: ' + userId + ', Tipo: ' + tipo);
    // window.location.href = 'editarUsuario.jsp?id=' + userId;
}

// ============= FUNCIONES PARA MANEJO DE ARCHIVOS =============
function dropHandler(e) {
    e.preventDefault();
    e.stopPropagation();
    
    if (e.dataTransfer.items) {
        const file = e.dataTransfer.items[0].getAsFile();
        if (file) {
            handleFileSelect(file);
        }
    }
}

function dragOverHandler(e) {
    e.preventDefault();
    e.stopPropagation();
    e.dataTransfer.dropEffect = 'copy';
}

function handleFileSelect(file) {
    const fileInput = document.getElementById('fileInput');
    const dataTransfer = new DataTransfer();
    dataTransfer.items.add(file);
    fileInput.files = dataTransfer.files;
    
    updateFileInfo(file);
}

function updateFileInfo(file) {
    const fileInfo = document.getElementById('fileInfo');
    const fileName = document.getElementById('fileName');
    const fileSize = document.getElementById('fileSize');
    
    fileName.textContent = file.name;
    fileSize.textContent = formatFileSize(file.size);
    fileInfo.style.display = 'block';
    
    // Validar tamaño máximo (50MB)
    if (file.size > 50 * 1024 * 1024) {
        alert('El archivo es demasiado grande. El tamaño máximo es 50MB.');
        removeFile();
        return;
    }
    
    // Validar extensión
    const allowedExtensions = ['.pdf', '.doc', '.docx'];
    const fileExtension = file.name.substring(file.name.lastIndexOf('.')).toLowerCase();
    
    if (!allowedExtensions.includes(fileExtension)) {
        alert('Formato de archivo no permitido. Solo se aceptan PDF, DOC y DOCX.');
        removeFile();
        return;
    }
}

function formatFileSize(bytes) {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
}

function removeFile() {
    const fileInput = document.getElementById('fileInput');
    const fileInfo = document.getElementById('fileInfo');
    
    fileInput.value = '';
    fileInfo.style.display = 'none';
}

function resetUploadForm() {
    const form = document.getElementById('uploadForm');
    if (form) {
        form.reset();
        removeFile();
    }
}

// ============= FUNCIONES PARA SELECCIÓN DE TESIS =============
function seleccionarTesis(tesisId) {
    const select = document.getElementById('tesisSelect');
    if (select) {
        select.value = tesisId;
        actualizarInfoTesis(tesisId);
        showSection('assign-section');
        // Scroll a la sección del formulario
        setTimeout(() => {
            const formSection = document.getElementById('assignFormSection');
            if (formSection) {
                formSection.scrollIntoView({ behavior: 'smooth' });
            }
        }, 100);
    }
}

function actualizarInfoTesis(tesisId) {
    const select = document.getElementById('tesisSelect');
    if (!select) return;
    
    const option = select.options[select.selectedIndex];
    const tesisInfo = document.getElementById('tesisInfo');
    
    if (option && option.value) {
        tesisInfo.style.display = 'block';
        document.getElementById('tesisTitulo').textContent = option.getAttribute('data-titulo') || '';
        document.getElementById('tesisEstudiante').textContent = option.getAttribute('data-estudiante') || '';
        document.getElementById('tesisCarrera').textContent = option.getAttribute('data-carrera') || '';
        document.getElementById('tesisFecha').textContent = option.getAttribute('data-fecha') || '';
    } else {
        tesisInfo.style.display = 'none';
    }
}

function actualizarInfoDocente(docenteId) {
    const select = document.getElementById('docenteSelect');
    if (!select) return;
    
    const option = select.options[select.selectedIndex];
    const docenteInfo = document.getElementById('docenteInfo');
    
    if (option && option.value) {
        docenteInfo.style.display = 'block';
        document.getElementById('docenteNombre').textContent = option.getAttribute('data-nombre') || '';
        document.getElementById('docenteEspecialidad').textContent = option.getAttribute('data-especialidad') || '';
        
        const asignadas = parseInt(option.getAttribute('data-asignadas')) || 0;
        const capacidad = parseInt(option.getAttribute('data-capacidad')) || 1;
        const carga = parseFloat(option.getAttribute('data-carga')) || 0;
        
        document.getElementById('docenteTesis').textContent = `${asignadas} de ${capacidad} tesis`;
        document.getElementById('docenteCarga').textContent = `${carga}%`;
        document.getElementById('docenteCargaBar').style.width = `${Math.min(carga, 100)}%`;
        document.getElementById('docenteDisponibilidad').textContent = option.getAttribute('data-disponibilidad') || '';
    } else {
        docenteInfo.style.display = 'none';
    }
}

function validarFechaLimite(input) {
    const fechaError = document.getElementById('fechaError');
    const hoy = new Date();
    hoy.setHours(0, 0, 0, 0);
    const fechaSeleccionada = new Date(input.value);
    
    if (fechaSeleccionada < hoy) {
        fechaError.style.display = 'block';
        input.style.borderColor = '#ef4444';
        return false;
    } else {
        fechaError.style.display = 'none';
        input.style.borderColor = '#e5e7eb';
        return true;
    }
}

// ============= INICIALIZACIÓN =============
document.addEventListener('DOMContentLoaded', function() {
    showSection('dashboard');
    
    // Configurar fecha límite por defecto
    const hoy = new Date();
    const fechaLimite = new Date(hoy.getTime() + 30 * 24 * 60 * 60 * 1000);
    
    if (document.getElementById('fechaLimite')) {
        document.getElementById('fechaLimite').value = fechaLimite.toISOString().split('T')[0];
    }
    
    if (document.getElementById('fechaLimiteSection')) {
        document.getElementById('fechaLimiteSection').value = fechaLimite.toISOString().split('T')[0];
    }
    
    // Configurar evento para el formulario de subida de archivos
    const uploadForm = document.getElementById('uploadForm');
    if (uploadForm) {
        uploadForm.addEventListener('submit', function(e) {
            const fileInput = document.getElementById('fileInput');
            const submitBtn = document.getElementById('submitBtn');
            const progressContainer = document.getElementById('progressContainer');
            const progressBar = document.getElementById('progressBar');
            const progressPercent = document.getElementById('progressPercent');
            const progressText = document.getElementById('progressText');
            
            if (fileInput.files.length === 0) {
                e.preventDefault();
                alert('Por favor, seleccione un archivo');
                return;
            }
            
            // Mostrar progreso
            submitBtn.disabled = true;
            submitBtn.innerHTML = 'Subiendo...';
            progressContainer.style.display = 'block';
            progressText.textContent = 'Subiendo archivo...';
            
            // Simular progreso (en producción, esto se manejaría con AJAX)
            let progress = 0;
            const interval = setInterval(() => {
                progress += 10;
                progressBar.style.width = progress + '%';
                progressPercent.textContent = progress + '%';
                
                if (progress >= 100) {
                    clearInterval(interval);
                    progressText.textContent = '¡Archivo subido!';
                    submitBtn.innerHTML = '¡Éxito!';
                }
            }, 300);
        });
    }
    
    // Configurar evento para el input de archivo
    const fileInput = document.getElementById('fileInput');
    if (fileInput) {
        fileInput.addEventListener('change', function(e) {
            if (this.files.length > 0) {
                handleFileSelect(this.files[0]);
            }
        });
    }
    
    // Configurar eventos para los selectores
    const tesisSelect = document.getElementById('tesisSelect');
    if (tesisSelect) {
        tesisSelect.addEventListener('change', function() {
            actualizarInfoTesis(this.value);
        });
    }
    
    const docenteSelect = document.getElementById('docenteSelect');
    if (docenteSelect) {
        docenteSelect.addEventListener('change', function() {
            actualizarInfoDocente(this.value);
        });
    }
    
    // Configurar validación de fecha límite
    const fechaLimiteInput = document.getElementById('fechaLimiteSection');
    if (fechaLimiteInput) {
        fechaLimiteInput.addEventListener('change', function() {
            validarFechaLimite(this);
        });
    }
});

    </script>
</body>
</html>