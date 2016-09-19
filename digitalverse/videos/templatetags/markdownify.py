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


    # Youtube embed
    pattern =  re.compile("(?:http?s?:\/\/)?(?:www\.)?(?:youtube\.com|youtu\.be)\/(?:watch\?v=)?(.[A-Za-z0-9\-\_]+)[\s\.\n]")
    replacement = r'<div class="flex-video widescreen youtube"><iframe width="640" height="360" src="http://www.youtube.com/embed/\1" frameborder="0" allowfullscreen></iframe></div>'    
    text = pattern.sub(replacement, text)        
    


    html = markdown.markdown(text)

    # Urlify
    # html = linkify(html, 180)
    return html

