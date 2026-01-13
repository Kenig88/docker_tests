from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import pytest


@pytest.fixture(autouse=True)
def driver():
    options = Options()
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument("--disable-dev-shm-usage")
    driver = webdriver.Chrome(options=options)
    yield driver
    driver.quit()


def test_inputs(driver):
    driver.get("https://the-internet.herokuapp.com/inputs")
    assert driver.find_element("xpath", "//h3[text()='Inputs']").text == "Inputs"


def test_context_menu(driver):
    driver.get("https://the-internet.herokuapp.com/context_menu")
    assert driver.find_element("xpath", "//h3[text()='Context Menu']").text == "Context Menu"
