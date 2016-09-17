# markdownify
from django import template
import markdown
import re
 
register = template.Library()



_urlfinderregex = re.compile(r'http([^\.\s]+\.[^\.\s]*)+[^\.\s]{2,}')

def linkify(text, maxlinklength):
    def replacewithlink(matchobj):
        url = matchobj.group(0)
        text = url
        if text.startswith('http://'):
            text = text.replace('http://', '', 1)
        elif text.startswith('https://'):
            text = text.replace('https://', '', 1)

        if text.startswith('www.'):
            text = text.replace('www.', '', 1)

        if len(text) > maxlinklength:
            halflength = maxlinklength / 2
            text = text[0:halflength] + '...' + text[len(text) - halflength:]

        return '<a href="' + url + '">' + url + '</a>'

    if text != None and text != '':
        return _urlfinderregex.sub(replacewithlink, text)
    else:
        return ''
    
@register.filter
def markdownify(text, short = "False"):
    if short == "True":
        try:
            text = text.split("<!-- more -->")[0].strip()
        except:
            pass
        text = text[:1024]

    # Urlify
    text = linkify(text, 180)
    
    html = markdown.markdown(text)

    return html

