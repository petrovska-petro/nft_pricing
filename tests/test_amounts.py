def test_pricing(NftOracle, gov):

    # ref: https://etherscan.io/tx/0x848bddd74eda97aa22c4db23e10dbb2bd2f9d3eb7a3bfdd89f99a2399bd3e3f4
    BOTTOM_RANGE = 158625

    # ref: https://etherscan.io/tx/0x0a231ac772e266332ae08d632dbcb8b81ccf82cb78e83e4b8d971ea29cbc7a97
    UPPER_RANGE = 151049

    usd_value_bottom = NftOracle.amountsInUsd(BOTTOM_RANGE)

    usd_value_upper = NftOracle.amountsInUsd(UPPER_RANGE)

    print(f"usd_value_bottom={usd_value_bottom:,}")
    print(f"usd_value_upper={usd_value_upper:,}")
    print(f"usd_total={(usd_value_upper + usd_value_bottom):,}")

    # as per uniswap UI, atm TVL is hovering at ~9.36m (4:20pm UTC, 7th Dec)
    TVL_IN_GRAPH = 9360000
    TVL_LIMIT = 9375000

    # gave ~$15k flex as chainlink oracle and pricing in uniswap v3 feeds may differ slighly
    assert (
        usd_value_bottom + usd_value_upper >= TVL_IN_GRAPH
        and usd_value_bottom + usd_value_upper <= TVL_LIMIT
    )
