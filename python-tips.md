#Testing

##Generating django south fixture for text data


1. Change name of database in settings:
   
    DATABASES = {
        'default': {
            'NAME': 'product_test',


1. Create new database with same permissions as regular database
1. `python manage.py syncdb --all`
1. Massage data
1. `python manage.py dumpdata --format=json --indent=4 app.ModelName > app/fixtures/test-modelname.json`
1. Add fixture.json to test fixture:

    class TestModels(TestCase):
        fixtures = ['test_all_models.json']
