# Reading Log guide

Every card and setting in one place. For the quick version, see the
[README](../README.md).

The ring designs and the idea of a reading dashboard come from
[u/fishnoogz](https://www.reddit.com/user/fishnoogz/)'s Reddit post.

## Install

1. Connect your e-reader by USB and show hidden folders.
2. Open `.adds/koreader/settings/bookshelf/`. If there is no `micromodules`
   folder inside `bookshelf`, create one.
3. Copy **everything inside** the release's `micromodules` folder (the
   `alm_*.lua` files and the `almanac` folder) into
   `.adds/koreader/settings/bookshelf/micromodules/`.
4. Restart KOReader.

Don't use the Bookshelf plugin's own `micromodules` folder
(`.adds/koreader/plugins/bookshelf.koplugin/micromodules/`). It is replaced
whenever Bookshelf updates.

To update, copy the new files over the old ones. Your layout and settings
are kept.

## Set up the Dashboard

1. Bookshelf menu > Settings > Micro modules: turn on **Full-screen button**.
2. Tap that button, at the bottom right of the home screen.
3. Long-press any module, tap the plus in a circle, and add
   **Reading Log · Dashboard**.
4. Long-press the Dashboard and tap **+** until it doesn't grow any more.
5. Long-press every other module and tap the bin to remove it.

## The pages

| Today | Yearly | Monthly |
| --- | --- | --- |
| ![Today](images/today.png) | ![Yearly](images/yearly.png) | ![Monthly](images/monthly.png) |
| Banner, Continue reading, Activity rings beside Week rings, Book club | Time read by month beside Longest reads (year), Books and pages, Year in covers | Month rings beside Month totals, Pages per day, When you read beside Longest reads (month) |

The fourth page, **Trends**, has Monthly challenge beside Finish forecast,
then Reading trends. The fifth, **Library**, has Library stats, Random pick
beside Most-read authors, then Quote of the day.

Tap the tabs at the bottom to switch pages.

**Looking back a month:** on the Monthly page, the left arrow at the top
steps back a month (up to twelve) and the right arrow steps forward. When
you're on another month, a **Today** button appears to bring you back. Every
card on the page follows.

### Editing the Dashboard

Long-press the Dashboard > Module settings > **Pages and cards**.

- Pick a page at the top, then tap a row to change its **Card**, what goes
  **Beside it**, its **Height**, or to move or remove it.
- **+ Add a row** adds one (up to six a page).
- **Tab name**, **Title on the page** and **Page shown / hidden** change the
  page itself, and **Move tab left / right** changes where its tab sits.
- **+ Add a page** adds a page of your own (up to seven tabs in all). It
  starts with one card; add rows to it like any other page. **Remove this
  page** takes away a page you added.
- **Put this page back as it came** undoes your changes to one of the
  built-in pages.
- To undo everything at once, long-press the Dashboard > Module settings >
  **Put the whole Dashboard back as it came**. Pages you added are removed;
  each card's own settings and the colours are kept.

## Cards on their own

Any card can also go on its own in Bookshelf's full-screen view or the home
screen's top area: long-press a module, tap the plus in a circle and pick a
`Reading Log · …` card. On their own the cards use Bookshelf's colours,
including its dark theme.

| | | | |
| --- | --- | --- | --- |
| ![Cards](images/cards-1.png) | ![More cards](images/cards-2.png) | ![Home screen](images/home-1.png) | ![Home screen](images/home-2.png) |

## The Mini dashboard

One row of small cards made for the top of the home screen (Bookshelf's top
panel). Turn on Bookshelf menu > Settings > Micro modules > **In the top panel**,
then long-press a module there, tap the plus in a circle and add
**Reading Log · Mini dashboard**.

As it comes it shows the book you're reading (tap it to open the book), with
a small row of today's rings under its progress (pages, minutes and streak),
then the Control centre. Tap the rings for your reading progress.
Long-press it > Module settings to pick up to three cards from Reading and
today's rings, Control centre, Continue reading, Activity rings, This week vs
last, Week rings, Monthly challenge, Finish forecast, Year goal, Today's
timeline, Random pick, Quote of the day and Library stats. It shows as many
as fit, left to right. The rings goals, the challenge, the comparison, the
pick and the buttons are shared with their full-size cards; **Control centre
buttons…** in its settings opens the button editor.

## The cards

Long-press a card > **Module settings** for its options.

| Card | What it shows | Tap | Settings |
| --- | --- | --- | --- |
| Banner | The time and date, and two lines of your own (empty until you type them). Styles: Heading, At a glance (with today's pages, time and streak) and Classic | Flashes the screen clean | Style, top line, bottom line |
| Continue reading | The book you're reading: cover, progress, time left, days of reading and time spent so far | Continue opens the book, Details opens the book menu, `1 / 5 >` shows the next book | How many books to step through |
| Activity rings | Today's pages, minutes and streak as three rings | Reading progress | Daily pages, daily minutes, streak length |
| Week rings | A pages ring and a minutes ring for each day this week, and your daily averages | Reading calendar | Daily pages, daily minutes |
| This week | A bar for each day this week | Reading calendar | Pages or minutes |
| Year goal | Books finished this year against your goal | | Goal, books read outside KOReader |
| Book club | This month's picks, your progress on each, days left, and how much of the club's list you've read | A book opens it | Collection, this month's books, title |
| Month rings | The two rings for every day of the month as a calendar, with your daily averages | Reading calendar | Daily pages, daily minutes |
| Month totals | Books finished, time read and pages read this month | The books figure lists the month's books | |
| Pages per day | A bar for each day of the month, with a line at your daily average | Reading calendar | Pages or time |
| When you read | The part of the day you read most in, a bar for each hour, and the morning, afternoon, evening and night split | | |
| Longest reads (month) | The month's books that took longest, by time or by days | A book opens its details | Longest by, how many |
| Time read by month | Hours read each month this year | A month lists its books | |
| Longest reads (year) | The year's books that took longest, by time or by days | A book opens its details | Longest by, how many |
| Books and pages | Books finished and pages read each month this year, as two lines | A month lists its books | Which pages to count |
| Year in covers | Every cover you finished this year, in order, with the months marked | A cover opens its details | Cover wall or stacked by month |
| Top genres | The genres you finished most this year | | How many |
| Reading heatmap | A square for each day, more strongly coloured the more you read | Reading calendar | |
| Recently finished | The last few books you finished | A cover opens the book menu | How many |
| TBR shelf | A row of covers from one collection | A cover opens the book | Collection, title, line underneath, how many, labels |
| Finish by | One book against a date: days left, pages a day needed, on pace or not | Opens the book | Book, date, label |
| Reading trends | Your last 90 days against your last year, like Apple's Fitness trends (see below) | Reading progress | |
| Monthly challenge | One goal for the month as a ring, how much each day still needs, on pace or not; on a wide card, your running total against the line to the goal | Reading calendar | What it counts, the target |
| Finish forecast | When you'll finish the book you're reading at your recent pace, the others in progress, and how many books your year is on pace for | A book opens it | Books listed |
| This week vs last | Your average a day this week against last week, as a sentence and two bars, like Apple Health | Reading calendar | Week, month or year; time read, pages or both |
| Today's timeline | Each sitting today as a block along the day, and a list of them: when, which book, how long | Reading calendar | |
| Library stats | How many books you own, have read, are reading, have on hold and haven't started | | Count again now |
| Most-read authors | Your top authors, by books finished or by hours read | | By books or time, how many |
| Random pick | A book you haven't started (see below) | Open opens it, Another picks again | How often, where from, genres, authors |
| Quote of the day | One of your highlights, and the book it's from | Opens the book; Another shows a different quote | |
| Mini dashboard | One row of small cards for the top of the home screen (see above) | Each small card does what its big one does | The cards, left to right |
| Control centre | Buttons for any action, lit when they're on, and brightness and warmth in ten steps | Each button runs its action; a step sets the light | Buttons (how many, and each one's action, icon and name), brightness and warmth shown or hidden |

### When tapped

Every card's settings have **When tapped**: keep the card's own action, open
the reading calendar or progress view, or run anything else (a plugin, a
KOReader action, a menu entry). Buttons on a card, like Continue and
Details, always keep their own job.

### Book club

1. In KOReader, make a collection with "bookclub" in its name (for example
   `bookclub 2026`) and add the club's books to it.
2. Long-press the card > Module settings > **October's books** (it shows the
   current month) and tick the month's picks. The arrows let you set up
   other months ahead of time.
3. Until you tick anything, the card shows the books from the collection
   you're in the middle of.

### How the rings work

Each ring is a goal. It fills clockwise from the top, and a closed ring means
you met the goal.

- **Activity rings:** outer is pages today against your daily goal, middle is
  minutes today against your daily goal, inner is your streak against 7 days.
- **Week rings** and **Month rings:** a pages ring (outer) and a minutes ring
  (inner) for each day, with a filled centre when you met both goals.

The goals are shared by all three cards; change them in any of their
settings.

### How Reading trends works

Like the Trends in Apple's Fitness app, each figure is your average over the
last 90 days against your average over the last 365, both ending yesterday:

- **Time read** (minutes a day) and **Pages** (pages a day)
- **Reading days** (days a week you read at all)
- **Session length** (minutes per sitting; a sitting ends after a break of
  more than ten minutes)
- **Reading speed** (pages an hour)
- **Books finished** (books a month)

A figure up on your year, or within 3 % of it, goes under **Keep it going**.
Further down, it goes under **Worth a look**, with a tip when there is room.
With less than four months of statistics, or too few sessions or finished
books to compare, it waits under **Needs more data**.

### Monthly challenge

As it comes, the challenge takes turns month by month (pages, then minutes,
then reading days) and sets a target a tenth above your daily rate over the
last three months, for the length of this month. Long-press the card >
Module settings to choose what it counts and to set your own target;
**Use the automatic target** goes back to the picked one.

### Finish forecast

The date is the book's time left (worked out from your reading speed in that
book) divided by your average reading time a day over the last 30 days. A
book with no time left on record uses its pages left and your pages a day
instead. The line along the bottom is where your year is heading at the rate
you have finished books so far.

### Control centre

- Long-press the card > Module settings: pick from 1 to 8 buttons (6 as it
  comes), and tap a button to change its **action** (a plugin, a KOReader action, a menu entry,
  a Bookshelf action), its **icon** (from Bookshelf's icon picker) and its
  **name**.
- Wi-Fi, night mode and the light buttons light up while they're on.
- Tap a step on the brightness or warmth bar to jump to it, or `−` and `+`
  to move one step. Warmth only shows on a device with a warm light.
- To put it on a Dashboard page: long-press the Dashboard > Module settings >
  **Pages and cards**, pick the page, tap **+ Add a row**, and pick Control
  centre.

### This week vs last

The figure for this week is your average a day over the days gone by so far.
Today joins in once it has raised the average, so a morning with nothing read
yet doesn't pull the week down. Last week is the whole of last week. Within
3 % either way counts as about the same. In its settings you can compare
this month with last month, or this year with last year, and show time read,
pages or both.

### Random pick

- **A new pick:** every day, every week, every month, or only when you tap
  **Another**. Another always works too.
- **Pick from:** the whole library or one collection (your TBR, say).
- **Only these genres / Only these authors:** tick as many as you like, or
  leave them on Any. The lists come from your books.
- It only picks books you haven't started. In a series it only offers the
  next book you haven't read: six books into eight, it picks the seventh and
  never the eighth. If you're in the middle of a book in that series, the
  series sits it out. If only a later book is in the collection you picked
  from, you get the one you should read first.

### Library stats and Most-read authors

They count the books in Bookshelf's library (your home folder, as deep as
Bookshelf looks). A book you've never opened counts as not started. The
count is kept for 15 minutes; **Count again now** in Library stats' settings
counts straight away. By books counts the books you've finished; by time
uses KOReader's reading statistics.

### Quote of the day

It shares Bookshelf's quote of the day, so both show the same highlight.
Tap **Another** for a different one. If you have no highlights yet, highlight
a line while you read.

### Today's timeline

A sitting ends after a break of more than ten minutes, like in Reading
trends. Each book has its own colour, and the line across the bar is now.

### How When you read works

KOReader's Reading statistics plugin records how long you spend on every
page and when. The card adds that time up by the hour of the day, for the
month the Monthly page is showing. Morning is 5 am to noon, afternoon noon
to 5 pm, evening 5 to 9 pm and night 9 pm to 5 am.

## Colours

Long-press any card > Module settings > **Look and colours** (applies to all
cards):

- **Theme:** White, Dark or Paper, for the Dashboard.
- **Accent colour** and **Second accent:** twelve colours chosen to show well
  on colour e-ink.
- **Cards on their own:** match Bookshelf (the default) or framed in the
  theme.
- **Week starts on:** follow KOReader, Monday or Sunday.

Each card's own **Card colour** setting picks plain or tinted, and which of
the two accents leads.

## Remove

Delete the `alm_*.lua` files and the `almanac` folder from
`settings/bookshelf/micromodules/`, then restart KOReader.
