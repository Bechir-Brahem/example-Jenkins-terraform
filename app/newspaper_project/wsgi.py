"""
WSGI config for newspaper_project project.

It exposes the WSGI callable as password_change_done.html module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.2/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'newspaper_project.settings')

application = get_wsgi_application()
