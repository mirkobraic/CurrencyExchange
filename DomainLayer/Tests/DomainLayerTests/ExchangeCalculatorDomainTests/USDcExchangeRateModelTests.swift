import Foundation
import Testing
@testable import DomainLayer

@Suite("USDcExchangeRateModel Tests")
struct USDcExchangeRateModelTests {

    func exchangeRateModelInstance() -> USDcExchangeRateModel {
        let ask = Decimal(3)
        let bid = Decimal(2)

        return USDcExchangeRateModel(ask: ask, bid: bid, book: "", date: nil)
    }

    @Test
    func `Calculate USDc price uses ask price when buying`() {
        let model = exchangeRateModelInstance()
        let tickerAmount = Decimal(12)

        let usdcPrice = model.calculateUSDcPrice(from: tickerAmount, action: .buying)
        let expected = Decimal(4)

        #expect(usdcPrice == expected)
    }

    @Test
    func `Calculate USDc price uses bid price when selling`() {
        let model = exchangeRateModelInstance()
        let tickerAmount = Decimal(12)

        let usdcPrice = model.calculateUSDcPrice(from: tickerAmount, action: .selling)
        let expected = Decimal(6)

        #expect(usdcPrice == expected)
    }

    @Test
    func `Calculate ticker price uses bid when buying`() {
        let model = exchangeRateModelInstance()
        let usdcAmount = Decimal(10)

        let tickerPrice = model.calculateTickerPrice(from: usdcAmount, action: .buying)
        let expected = Decimal(30)

        #expect(tickerPrice == expected)
    }

    @Test
    func `Calculate ticker price uses ask when selling`() {
        let model = exchangeRateModelInstance()
        let usdcAmount = Decimal(10)

        let tickerPrice = model.calculateTickerPrice(from: usdcAmount, action: .selling)
        let expected = Decimal(20)

        #expect(tickerPrice == expected)
    }

    @Test
    func `Calculating USDc price with zero ask`() {
        let model = USDcExchangeRateModel(ask: 0, bid: 1, book: "", date: nil)
        let tickerAmount = Decimal(1)

        let usdcPrice = model.calculateUSDcPrice(from: tickerAmount, action: .buying)
        let expected = Decimal(0)

        #expect(usdcPrice == expected)
    }

    @Test
    func `Calculating USDc price with zero bid`() {
        let model = USDcExchangeRateModel(ask: 1, bid: 0, book: "", date: nil)
        let tickerAmount = Decimal(10)

        let usdcPrice = model.calculateUSDcPrice(from: tickerAmount, action: .selling)
        let expected = Decimal(0)

        #expect(usdcPrice == expected)
    }

    @Test
    func `Ticker to USDc and back is consistent for buying`() {
        let model = exchangeRateModelInstance()
        let originalTickerAmount = Decimal(12)

        let usdcPrice = model.calculateUSDcPrice(from: originalTickerAmount, action: .buying)
        let tickerBackAmount = model.calculateTickerPrice(from: usdcPrice, action: .buying)

        #expect(originalTickerAmount == tickerBackAmount)
    }

    @Test
    func `Ticker to USDc and back is consistent for selling`() {
        let model = exchangeRateModelInstance()
        let originalTickerAmount = Decimal(12)

        let usdcPrice = model.calculateUSDcPrice(from: originalTickerAmount, action: .selling)
        let tickerBackAmount = model.calculateTickerPrice(from: usdcPrice, action: .selling)

        #expect(originalTickerAmount == tickerBackAmount)
    }

    @Test
    func `USDc to ticker and back is consistent for buying`() {
        let model = exchangeRateModelInstance()
        let originalUSDcAmount = Decimal(12)

        let tickerPrice = model.calculateTickerPrice(from: originalUSDcAmount, action: .buying)
        let usdcBackAmount = model.calculateUSDcPrice(from: tickerPrice, action: .buying)

        #expect(originalUSDcAmount == usdcBackAmount)
    }

    @Test
    func `USDc to ticker and back is consistent for selling`() {
        let model = exchangeRateModelInstance()
        let originalUSDcAmount = Decimal(12)

        let tickerPrice = model.calculateTickerPrice(from: originalUSDcAmount, action: .selling)
        let usdcBackAmount = model.calculateUSDcPrice(from: tickerPrice, action: .selling)

        #expect(originalUSDcAmount == usdcBackAmount)
    }

}
