# [Proof of Concept] openITCOCKPIT-documentation

This repository contains the documentation of openITCOCKPIT in German and English language.

## Setup local copy

Clone this repository

```
apt-get install git python3 python3-pip

pip install mkdocs
pip install mkdocs-material
pip install markdown-include
```

## Run Webserver
```
cd de/

mkdocs serve
```

Open `http://XXX.XXX.XXX.XXX:8000/` with your Webbrowser

## Setup local copy via Docker

1. Clone this repository
```
git clone https://github.com/it-novum/openITCOCKPIT-documentation.git
cd openITCOCKPIT-documentation/
```

2. Build Docker image
```
docker build . -t openitcockpit/mkdocs
```

3. Run Docker Contianer (German Docs [🇩🇪])
```
docker run --rm -it -v "$PWD/de":/docs -w /docs -p 8000:8000 openitcockpit/mkdocs
```

3. Run Docker Contianer (English Docs [🇺🇸])
```
docker run --rm -it -v "$PWD/en":/docs -w /docs -p 8000:8000 openitcockpit/mkdocs
```

4. Open in Web Browser
```
http://127.0.0.1:8000/
```

5. Edit the files

You can edit the files with your favorite editor. Docker will copy changed files automatically into the container. No manual effort required.

## License
```
Copyright (C) 2015-2020  it-novum GmbH


openITCOCKPIT is dual licensed

1)
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.


This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.


You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

2)
If you purchased an openITCOCKPIT Enterprise Edition you can use this file
under the terms of the openITCOCKPIT Enterprise Edition licence agreement.
Licence agreement and licence key will be shipped with the order
confirmation.
```
