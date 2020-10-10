# MarkPress 2.0 Changelog & Notes

## Tree Structure

- Previously: posts were loaded from a predetermined path: {folder}/{post}.md
- Posts are now compatible with tree sturctures
- folders are now automatically considered "show_news" pages
- posts automatically load the "show_post" page
- Posts are determined by the absense of a trailing slash
- Folders are determined by the existence of a trailing slash.

##### Example:

- /mentalist/patrick_jane
    - read file: /posts/mentalist/patrick_jane.md
- /mentalist/
    - read directory: /posts/mentalist (list files as posts)

### Wikitten Theme (Licensed under MIT)

- We are moving to a theme adapted from wikitten (MIT licence)
- It includes wikipedia-like infobox (not from theme)
    - Infobox can has a specific structure
        - header (required)
        - subheader (optional)
        - image (optional)
            - href (required)
            - alt (optional)
        - table (optional)
            - header (required)
            - content (optional, HTML/List)
                - list (optional)

#### Upcoming Changes

- Theme Sidebar Navigation
- Theme Breadcrumbs Navigation

#### Infobox Example Format

    ---
    title: Castiel (Supernatural)
    infobox:
        header: Castiel
        subheader: <a href="/wiki/Supernatural_(U.S._TV_series)" class="mw-redirect" title="Supernatural (U.S. TV series)">Supernatural</a></i> character
        image:
            href: /MarkPress/assets/stories/supernatural/Castiel_(supernatural).jpg
            alt: Castiel (supernatural).jpg
        image_header: Castiel portrayed by <a href="/wiki/Misha_Collins" title="Misha Collins">Misha Collins</a> in the TV series <i><a href="/wiki/Supernatural_(U.S._TV_series)" class="mw-redirect" title="Supernatural (U.S. TV series)">Supernatural</a></i>
        table:
        -
            header: First appearance
            content:
                list:
                - <a href="/wiki/Lazarus_Rising_(Supernatural)" title="Lazarus Rising (Supernatural)">Lazarus Rising</a>
                - September 18, 2008<span style="display:none"> (<span class="bday dtstart published updated">2008-09-18</span>)</span>
        -
            header: Created by
            content: <a href="/wiki/Eric_Kripke" title="Eric Kripke">Eric Kripke</a>
        -
            header: Portrayed by
            content: <a href="/wiki/Misha_Collins" title="Misha Collins">Misha Collins</a>
        -
            type: header
            header: In-universe information
        -
            header: Names
            content:
                list:
                - Cass<br>
                - Clarence (by Meg)<br>
                - Feathers (by Crowley)
        -
            header: Species
            content: <a href="/wiki/Angel" title="Angel">Angel</a> (<a href="/wiki/Seraph" title="Seraph">Seraph</a>)
        -
            header: Family
            content:
                list:
                - Jack Kline (nephew; adoptive son)<br>
                - The Winchesters (adoptive family)
    ---


---

