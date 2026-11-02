import os
from pathlib import Path
from playwright.sync_api import sync_playwright

out = Path('evidencias')
out.mkdir(exist_ok=True)
with sync_playwright() as p:
    browser = p.chromium.launch()
    page = browser.new_page(viewport={'width': 1280, 'height': 850}, locale='en-US')
    try:
        page.goto('http://127.0.0.1:8080', wait_until='networkidle')
        page.screenshot(path=str(out / '01-acceso.png'), full_page=True)
        page.locator('#input_username').fill('root')
        page.locator('#input_password').fill(os.environ['MYSQL_ROOT_PASSWORD'])
        page.locator('#input_go').click()
        page.wait_for_load_state('networkidle')
        page.get_by_role('link', name='Databases').first.click()
        page.wait_for_load_state('networkidle')
        field = page.locator('input[name="new_db"]')
        field.fill('test_red')
        page.screenshot(path=str(out / '02-crear-base.png'), full_page=True)
        form = field.locator('xpath=ancestor::form')
        form.locator('input[type="submit"], button[type="submit"]').first.click()
        page.wait_for_load_state('networkidle')
        page.wait_for_timeout(1500)
        page.screenshot(path=str(out / '03-base-creada.png'), full_page=True)
        assert page.get_by_text('test_red', exact=True).count() > 0, 'No se ve test_red en la interfaz'
        (out / 'interfaz.txt').write_text(page.locator('body').inner_text())
        print('Base test_red creada desde el formulario de phpMyAdmin.')
    except Exception:
        page.screenshot(path=str(out / 'error.png'), full_page=True)
        (out / 'error-interfaz.txt').write_text(page.locator('body').inner_text())
        print(page.locator('body').inner_text())
        print(page.locator('input,button').evaluate_all('(els) => els.map(e => ({tag:e.tagName,id:e.id,name:e.name,type:e.type,text:e.innerText}))'))
        raise
    finally:
        browser.close()