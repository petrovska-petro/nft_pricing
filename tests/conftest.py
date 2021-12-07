import pytest


@pytest.fixture(scope="module")
def gov(accounts):
    yield accounts[0]


@pytest.fixture
def NftOracle(NftPricing, gov):
    nftPricing = gov.deploy(NftPricing)

    yield nftPricing
