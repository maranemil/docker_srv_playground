import sys


def handler(event, context):
    """
    Lambda Handler

    :param event:
    :param context:
    :return:
    """
    call_values()
    return 'Hello World from AWS Lambda using Python' + sys.version + '!'


def call_values():
    pass


print('lambda_handler job installed')
