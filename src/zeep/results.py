import typing


class SoapResult(typing.NamedTuple):
    result: typing.Any
    http_response: typing.Any
    envelope: typing.Any
