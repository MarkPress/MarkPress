# Dev Notes

## Changes Made

- Switched from [Ciconia](https://github.com/kzykhys/Ciconia) to [Parsedown](https://github.com/erusev/parsedown) as Markdown Parser
    - I was having some issues with linking to URLs like `/any_url_with _underscore`
    - seems to be  a common markdown parsing issue
    - Parsedown handles it properly, out of the box

## Incoming Changes

- I had some issues with Twig not working on PHP 5.4
    - I'm still running most of my code on Bitnami PHP 5.4 setup (lazy)
    - I refuse to make code incompatible with old versions just for the sake of it. But some libraries seem to make it their mission.

For some reason the latest version of Twig has incompatible code it wishes to remove (it says so in the files that throw errors) yet they keep the code in there, for whatever incomprehensible reason. Which compounded my frustration as for some reason my server refuses to send error messages, and just renders nothing.

After wasting an hour or so, until I figured out it was a PHP version issue, I went looking for some Twig alternatives, which for some reason are all WORSE than Twig, I ended up just finding dumping the old version in the system folder. I also pulled in Parsedown and manually removed Ciconia, so I guess that works.

##### Template Engines, Imrpovements; Upgrades; Alternatives

[Plates](https://platesphp.com/) looks like a nice alternative, I've used it before. But I didn't feel the need to switch from Twig like templating. I did try a [Blade](https://github.com/jenssegers/blade) templating engine, which I have written down for potential future changes, I like it and it's simple, but as with Twig its ... using some code thats not compatible with old versions so I'll likely do a fully functional **PHP 5.4 version** and then I'll likely upgrade the template engine for a **PHP 7.x version**. I tried the Blade implementation, It's not hard, so I could make it optional, so that the theme can be specified as either twig or blade and then use a variable switch to use the appropriate library. Then you can just use whichever you prefer.