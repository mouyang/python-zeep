.. _settings:

========
Settings
========

.. currentmodule:: zeep.settings

.. versionadded:: 3.0

Context manager
---------------
You can set various options directly as attribute on the client or via a
context manager.

For example to let zeep return the raw response directly instead of processing
it you can do the following:

.. code-block:: python

    from zeep import Client
    from zeep import xsd

    client = Client('http://my-endpoint.com/production.svc?wsdl')

    with client.settings(raw_response=True):
        response = client.service.myoperation()

        # response is now a regular requests.Response object
        assert response.status_code == 200
        assert response.content

To return both the deserialized value and response metadata you can enable
``full_result``:

.. code-block:: python

    from zeep import Client

    client = Client('http://my-endpoint.com/production.svc?wsdl')

    with client.settings(full_result=True):
        response = client.service.myoperation()

        assert response.result is not None
        assert response.http_response.status_code == 200
        assert response.envelope is not None

The ``raw_response`` and ``full_result`` settings are mutually exclusive.

API
---

.. automodule:: zeep.settings
   :members:
