Styro: Instructions for Use
===========================

In just a few moments, you'll have a beautiful, modern webpage with which you can dazzle the world. These simple instructions will guide you through this generally painless process, which *will* include quite a lot of copying and pasting. We haven't much time, so let's begin.

Step 1
------

Download Styro and move `stylesheet.css` and `index.html` into your project's root directory.

Step 2
------

Select a cover image. Perhaps a public domain file from [Wikimedia Commons](https://commons.wikimedia.org/wiki/Commons:Picture_of_the_Year) will do? Bluish images work best with the default setup.

Edit the image in GIMP. Target specs:
* Size: ~150 KB
* Dimensions: 1800 x 900
* Format: JPEG

Call this image `cover.jpg` and stick it in the root directory.

Step 3
------

We will now create the header section.

First, add title and subtitle text. Use multiple `<h1>` tags for multi-line titles.

You may also add a small (64 x 64) logo or emblem above the title:

```
<img class="top-logo" src="logo.png">
<h1>...
```

Below the subtitle is where you should add call-to-action buttons.

Step 4
------

Now we're ready to add the sections that will make up our webpage.

Simply choose from the following possibilities and add them by copying and pasting them after the header.

Give each section you add a unique element ID: `section-1`, `section-2`, etc. You will then be able to adjust the color schemes for each section individually (Step 5).

### Text section

Just text, perhaps for an intro or short summary.

```
<section id="section-">
  <div class="text-section">
    [Text...]
    <br><br>
    [More text...]
  </div>
</section>
```

### Content section

Text with heading on the left, image on the right.

```
<section id="section-">
  <div class="content-section">
    <img src="[Image path]" class="feature">
    <h3>[Heading]</h3>
    [Text...]
  </div>
</section>
```

Target specs for images:
* Size: ~30 KB
* Dimensions: At least 400 pixels wide, with width > height
* Format: PNG

### Mirrored content section

Text with heading on the *right*, image on the *left*. Should be used alternately with the normal content section.

```
<section id="section-">
  <div class="content-section">
    <img src="[Image path]" class="feature mirrored">
    <h3>[Heading]</h3>
    [Text...]
  </div>
</section>
```

Target specs for images: same as above, believe it or not.

### Three-column section

Three columns, each with an icon, a heading, and text.

```
<section id="section-">
  <div class="content-section pure-g">
    <div class="pure-u-1-3 column">
      <img class="column-icon" src="[Icon path]">
      <br>
      <h4>[Heading]</h4>
      [Text...]
    </div>
    <div class="pure-u-1-3 column">
      <img class="column-icon" src="[Icon path]">
      <br>
      <h4>[Heading]</h4>
      [Text...]
    </div>
    <div class="pure-u-1-3 column">
      <img class="column-icon" src="[Icon path]">
      <br>
      <h4>[Heading]</h4>
      [Text...]
    </div>    
  </div>
</section>
```

Target specs for icons:
* Size: ~2 KB
* Dimensions: 60 x 60
* Format: PNG

### Footer section

Closing section, designed for just text.

```
<section id="section-">
  <div class="footer-section">
    [Text...]
  </div>
</section>
```

Step 5
------

At the bottom of the CSS file, add definitions for each section (by ID):

```
#section-1 {
    background-color: [Background color];
    color: [Font color];
}
```

You can set custom colors for links like this:

```
#section-1 a {
    color: [Link color];
}
```

Step 6
------

You should now have a decent webpage.

Some final CSS tweaks you may want to consider (and what to Ctrl+F to find them):
* Changing the page font (`font-family`)
* Changing the blend mode for the cover photo (`background-blend-mode`)
* Adding borders to images in content sections (`.feature`) 

Other optimizations:
* You can remove Font Awesome if you aren't using it
* You can remove Pure if you aren't using any three-column sections