# markdownify
from django import template
import markdown

 
register = template.Library()
 
@register.filter
def markdownify(text, short = "False"):
    if short == "True":
        try:
            text = text.split("<!-- more -->")[0].strip()
        except:
            pass
        text = text[:1024]

    html = markdown.markdown(text)

    return html

