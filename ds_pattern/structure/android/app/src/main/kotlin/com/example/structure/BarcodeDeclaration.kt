package com.example.structure

class BarcodeDeclaration {
    enum class SYMBOLOGY_IDENT(private val value: Int) {
        NOT_READ(-1),
        UNKNOWN(0),
        Code39(1),
        Codabar(2),
        Code128(3),
        Discrete2of5(4),
        IATA(5),
        Interleaved2of5(6),
        Code93(7),
        UPCA(8),
        UPCE0(9),
        EAN8(10),
        EAN13(11),
        Code11(12),
        Code49(13),
        MSI(14),
        EAN128(15),
        UPCE1(16),
        PDF417(17),
        Code16K(18),
        Code39FullASCII(19),
        UPCD(20),
        Code39Trioptic(21),
        Bookland(22),
        CouponCode(23),
        NW7(24),
        ISBT128(25),
        MicroPDF(26),
        DataMatrix(27),
        QRCode(28),
        MicroPDFCCA(29),
        PostNetUS(30),
        PlanetCode(31),
        Code32(32),
        ISBT128Con(33),
        JapanPostal(34),
        AustralianPostal(35),
        DutchPostal(36),
        MaxiCode(37),
        CanadianPostal(38),
        UKPostal(39),
        MacroPDF(40),
        MacroQR(41),
        MicroQR(44),
        Aztec(45),
        AztecRune(46),
        GS1DataBar14(48),
        GS1DataBarLimited(49),
        GS1DataBarExpanded(50),
        USPS4CB(52),
        UPU4State(53),
        ISSN(54),
        Scanlet(55),
        CueCode(56),
        Matrix2of5(57),
        UPCA_2Supplemental(72),
        UPCE0_2Supplemental(73),
        EAN8_2Supplemental(74),
        EAN13_2Supplemental(75),
        UPCE1_2Supplemental(80),
        CCA_EAN128(81),
        CCA_EAN13(82),
        CCA_EAN8(83),
        CCA_GS1DataBarExpanded(84),
        CCA_GS1DataBarLimited(85),
        CCA_GS1DataBar14(86),
        CCA_UPCA(87),
        CCA_UPCE(88),
        CCC_EAN128(89),
        TLC39(90),
        CCB_EAN128(97),
        CCB_EAN13(98),
        CCB_EAN8(99),
        CCB_GS1DataBarExpanded(100),
        CCB_GS1DataBarLimited(101),
        CCB_GS1DataBar14(102),
        CCB_UPCA(103),
        CCB_UPCE(104),
        SignatureCapture(105),
        Chinese2of5(114),
        Korean3of5(115),
        UPCA_5supplemental(136),
        UPCE0_5supplemental(137),
        EAN8_5supplemental(138),
        EAN13_5supplemental(139),
        UPCE1_5Supplemental(144),
        MacroMicroPDF(154),
        GS1DatabarCoupon(180),
        HanXin(183),
        NEC2of5(184),
        Straight2of5_IATA(185),
        Straight2of5_Industrial(186),
        Telepen(187),
        GS1128(188),
        BritishPost(189),
        InfoMail(190),
        IntelligentMailBarcode(191),
        KIXPost(192),
        Postal_4i(193),
        Plessey(194),

        Code128_FNC1_First_Position(195),
        Code128_FNC1_Second_Position(196),
        UPC_EAN(197),
        UPC_EAN_Two_digit_supplement_data_only(198),
        UPC_EAN_Five_digit_supplement_data_only(199),
        Codabar_No_Check_Digit(200),
        Codabar_Check_Digit(201),
        Interleaved2of5_No_Check_Digit(202),
        Interleaved2of5_Validate(203),
        Interleaved2of5_Validate_Stripped_Check_Digit(204),
        MSI_Mod10_CheckDigit_Transmit(205),
        MSI_Mod10_CheckDigit_Not_Transmit(206),
        GS1Databar(207),

        CODABLOCK_A(208),
        CODABLOCK_F(209),
        GS1_COMPOSITE_AB(210),
        GS1_COMPOSITE_C(211),
        GS1DataBarOmnidirection(222),
        Standard2of5(223),

        Code39_Code32(224),
        Code128_ISBT_128(225);

        fun getValue(): Int {
            return value
        }

        companion object {
            fun fromInteger(x: Int): SYMBOLOGY_IDENT {
                var enRes = UNKNOWN
                when (x) {
                    1 -> enRes = Code39
                    2 -> enRes = Codabar
                    3 -> enRes = Code128
                    4 -> enRes = Discrete2of5
                    5 -> enRes = IATA
                    6 -> enRes = Interleaved2of5
                    7 -> enRes = Code93
                    8 -> enRes = UPCA
                    9 -> enRes = UPCE0
                    10 -> enRes = EAN8
                    11 -> enRes = EAN13
                    12 -> enRes = Code11
                    13 -> enRes = Code49
                    14 -> enRes = MSI
                    15 -> enRes = EAN128
                    16 -> enRes = UPCE1
                    17 -> enRes = PDF417
                    18 -> enRes = Code16K
                    19 -> enRes = Code39FullASCII
                    20 -> enRes = UPCD
                    21 -> enRes = Code39Trioptic
                    22 -> enRes = Bookland
                    23 -> enRes = CouponCode
                    24 -> enRes = NW7
                    25 -> enRes = ISBT128
                    26 -> enRes = MicroPDF
                    27 -> enRes = DataMatrix
                    28 -> enRes = QRCode
                    29 -> enRes = MicroPDFCCA
                    30 -> enRes = PostNetUS
                    31 -> enRes = PlanetCode
                    32 -> enRes = Code32
                    33 -> enRes = ISBT128Con
                    34 -> enRes = JapanPostal
                    35 -> enRes = AustralianPostal
                    36 -> enRes = DutchPostal
                    37 -> enRes = MaxiCode
                    38 -> enRes = CanadianPostal
                    39 -> enRes = UKPostal
                    40 -> enRes = MacroPDF
                    41 -> enRes = MacroQR
                    44 -> enRes = MicroQR
                    45 -> enRes = Aztec
                    46 -> enRes = AztecRune
                    48 -> enRes = GS1DataBar14
                    49 -> enRes = GS1DataBarLimited
                    50 -> enRes = GS1DataBarExpanded
                    52 -> enRes = USPS4CB
                    53 -> enRes = UPU4State
                    54 -> enRes = ISSN
                    55 -> enRes = Scanlet
                    56 -> enRes = CueCode
                    57 -> enRes = Matrix2of5
                    72 -> enRes = UPCA_2Supplemental
                    73 -> enRes = UPCE0_2Supplemental
                    74 -> enRes = EAN8_2Supplemental
                    75 -> enRes = EAN13_2Supplemental
                    80 -> enRes = UPCE1_2Supplemental
                    81 -> enRes = CCA_EAN128
                    82 -> enRes = CCA_EAN13
                    83 -> enRes = CCA_EAN8
                    84 -> enRes = CCA_GS1DataBarExpanded
                    85 -> enRes = CCA_GS1DataBarLimited
                    86 -> enRes = CCA_GS1DataBar14
                    87 -> enRes = CCA_UPCA
                    88 -> enRes = CCA_UPCE
                    89 -> enRes = CCC_EAN128
                    90 -> enRes = TLC39
                    97 -> enRes = CCB_EAN128
                    98 -> enRes = CCB_EAN13
                    99 -> enRes = CCB_EAN8
                    100 -> enRes = CCB_GS1DataBarExpanded
                    101 -> enRes = CCB_GS1DataBarLimited
                    102 -> enRes = CCB_GS1DataBar14
                    103 -> enRes = CCB_UPCA
                    104 -> enRes = CCB_UPCE
                    105 -> enRes = SignatureCapture
                    114 -> enRes = Chinese2of5
                    115 -> enRes = Korean3of5
                    136 -> enRes = UPCA_5supplemental
                    137 -> enRes = UPCE0_5supplemental
                    138 -> enRes = EAN8_5supplemental
                    139 -> enRes = EAN13_5supplemental
                    144 -> enRes = UPCE1_5Supplemental
                    154 -> enRes = MacroMicroPDF
                    180 -> enRes = GS1DatabarCoupon
                    183 -> enRes = HanXin
                    184 -> enRes = NEC2of5
                    185 -> enRes = Straight2of5_IATA
                    186 -> enRes = Straight2of5_Industrial
                    187 -> enRes = Telepen
                    188 -> enRes = GS1128
                    189 -> enRes = BritishPost
                    190 -> enRes = InfoMail
                    191 -> enRes = IntelligentMailBarcode
                    192 -> enRes = KIXPost
                    193 -> enRes = Postal_4i
                    194 -> enRes = Plessey
                    195 -> enRes = Code128_FNC1_First_Position
                    196 -> enRes = Code128_FNC1_Second_Position
                    197 -> enRes = UPC_EAN
                    198 -> enRes = UPC_EAN_Two_digit_supplement_data_only
                    199 -> enRes = UPC_EAN_Five_digit_supplement_data_only
                    200 -> enRes = Codabar_No_Check_Digit
                    201 -> enRes = Codabar_Check_Digit
                    202 -> enRes = Interleaved2of5_No_Check_Digit
                    203 -> enRes = Interleaved2of5_Validate
                    204 -> enRes = Interleaved2of5_Validate_Stripped_Check_Digit
                    205 -> enRes = MSI_Mod10_CheckDigit_Transmit
                    206 -> enRes = MSI_Mod10_CheckDigit_Not_Transmit
                    207 -> enRes = GS1Databar
                    208 -> enRes = CODABLOCK_A
                    209 -> enRes = CODABLOCK_F
                    210 -> enRes = GS1_COMPOSITE_AB
                    211 -> enRes = GS1_COMPOSITE_C
                    222 -> enRes = GS1DataBarOmnidirection
                    223 -> enRes = Standard2of5
                    224 -> enRes = Code39_Code32
                    225 -> enRes = Code128_ISBT_128
                }
                return enRes
            }
        }
        

    }
}
