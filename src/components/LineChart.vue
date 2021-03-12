<template>
  <div id="swe-chart-container">
    <svg
      id="swe-chart"
      viewBox="0 0 800 500"
    >
      <g id="xAxis">
        <g id="ticks">
          <line
            class="axis-tick"
            x1="94"
            y1="443.8"
            x2="721.8"
            y2="443.8"
          />
          <line
            class="axis-tick"
            x1="176.2"
            y1="444.5"
            x2="176.2"
            y2="466"
          />
          <line
            class="axis-tick"
            x1="447.8"
            y1="444.5"
            x2="447.8"
            y2="466"
          />
        </g>
        <text
          class="cls-2"
          transform="translate(183.7 459.7)"
        >Jan 2011 </text>
        <text
          class="cls-2"
          transform="translate(455.9 459.7)"
        >Jan 2012</text>
      </g>
      <g id="area-swe">
        <polygon
          id="area-swe"
          class="area swe"
          points="721.1 403.9 720 403.9 719.3 403.9 718.6 404.8 717.8 405.5 717.1 405.5 716.4 407.1 715.7 407.1 715 407.1 714.3 407.1 713.5 408.7 712.8 411.2 712.1 413.5 711.4 418.3 710.7 419.2 709.6 419.2 708.9 419.9 708.2 419.9 707.4 419.9 706.7 421.5 706 424 705.3 426.3 704.6 431.1 703.9 432.6 703.1 432.6 702.4 432.6 701.7 432.6 701 432 700.3 432 699.2 432 698.5 432 697.8 432 697 432 696.3 432 695.6 430.4 694.9 430.4 694.2 430.4 693.5 430.4 692.7 430.4 692 430.4 691.3 430.4 690.6 430.4 689.9 430.4 688.8 430.4 688.1 431.1 687.4 431.1 686.6 431.1 685.9 431.1 685.2 431.1 684.5 432 683.8 433.6 683.1 433.6 682.3 433.6 681.6 433.6 680.9 433.6 680.2 433.6 679.5 433.6 678.4 433.6 677.7 433.6 677 433.6 676.2 433.6 675.5 433.6 674.8 433.6 674.1 433.6 673.4 433.6 672.6 435.2 671.9 439 671.2 441.5 670.5 441.5 669.8 441.5 669.1 441.5 668 441.5 667.3 441.5 666.5 441.5 665.8 441.5 665.1 441.5 664.4 441.5 663.7 441.5 663 441.5 662.2 441.5 661.5 441.5 660.8 441.5 660.1 441.5 659.4 441.5 658.7 441.5 657.6 441.5 656.9 441.5 656.1 441.5 655.4 441.5 654.7 441.5 654 441.5 653.3 441.5 652.6 441.5 651.8 441.5 651.1 441.5 650.4 441.5 649.7 441.5 649 441.5 648.3 441.5 647.2 441.5 646.5 441.5 645.7 441.5 645 441.5 644.3 441.5 643.6 441.5 642.9 441.5 642.2 441.5 641.4 441.5 640.7 441.5 640 441.5 639.3 441.5 638.6 441.5 637.8 441.5 636.8 441.5 636.1 441.5 635.3 441.5 634.6 441.5 633.9 441.5 633.2 441.5 632.5 441.5 631.7 441.5 631 441.5 630.3 441.5 629.6 441.5 628.9 441.5 628.2 441.5 627.4 441.5 626.4 441.5 625.6 441.5 624.9 441.5 624.2 441.5 623.5 441.5 622.8 441.5 622.1 441.5 621.3 441.5 620.6 441.5 619.9 441.5 619.2 441.5 618.5 441.5 617.8 441.5 617 441.5 616 441.5 615.2 441.5 614.5 441.5 613.8 441.5 613.1 441.5 612.4 441.5 611.7 441.5 610.9 441.5 610.2 441.5 609.5 441.5 608.8 441.5 608.1 441.5 607.4 441.5 606.6 441.5 605.6 441.5 604.8 441.5 604.1 441.5 603.4 441.5 602.7 441.5 602 441.5 601.3 441.5 600.5 441.5 599.8 441.5 599.1 441.5 598.4 441.5 597.7 441.5 597 441.5 596.2 441.5 595.2 441.5 594.4 441.5 593.7 441.5 593 441.5 592.3 441.5 591.6 441.5 590.9 441.5 590.1 441.5 589.4 441.5 588.7 441.5 588 441.5 587.3 441.5 586.5 441.5 585.8 441.5 584.8 441.5 584 441.5 583.3 441.5 582.6 441.5 581.9 441.5 581.2 441.5 580.4 441.5 579.7 441.5 579 441.5 578.3 441.5 577.6 441.5 576.9 441.5 576.1 441.5 575.4 441.5 574.3 441.5 573.6 441.5 572.9 441.5 572.2 441.5 571.5 441.5 570.8 441.5 570 441.5 569.3 441.5 568.6 441.5 567.9 441.5 567.2 438.3 566.5 434.2 565.7 430.4 565 422.4 563.9 418.3 563.2 410.3 562.5 404.8 561.8 400 561.1 399.1 560.4 398.4 559.6 399.1 558.9 395.9 558.2 391.8 557.5 397.5 556.8 400 556.1 397.5 555.3 387.9 554.6 382.2 553.5 385.4 552.8 380 552.1 372.7 551.4 369.5 550.7 364 550 362.4 549.2 363.1 548.5 365.6 547.8 366.3 547.1 364.7 546.4 364 545.6 364 544.9 366.3 544.2 373.6 543.1 368.8 542.4 364 541.7 360.8 541 357.6 540.3 356 539.5 352.6 538.8 351 538.1 352.6 537.4 350.3 536.7 348.7 536 346.2 535.2 343 534.5 341.4 533.8 341.4 532.7 341.4 532 341.4 531.3 343 530.6 343.9 529.9 343.9 529.1 344.6 528.4 345.5 527.7 345.5 527 345.5 526.3 345.5 525.6 346.2 524.8 345.5 524.1 345.5 523.4 345.5 522.3 345.5 521.6 345.5 520.9 345.5 520.2 347.1 519.5 349.4 518.7 351 518 350.3 517.3 349.4 516.6 347.8 515.9 347.8 515.2 347.1 514.4 347.1 513.7 347.1 513 347.1 511.9 345.5 511.2 344.6 510.5 344.6 509.8 344.6 509.1 343.9 508.3 343.9 507.6 343.9 506.9 343.9 506.2 343 505.5 343 504.8 343 504 343 503.3 343 502.6 343 501.5 343 500.8 343 500.1 343 499.4 342.3 498.7 342.3 497.9 342.3 497.2 343 496.5 345.5 495.8 346.2 495.1 347.1 494.3 347.1 493.6 349.4 492.9 350.3 492.2 350.3 491.1 350.3 490.4 351.9 489.7 355.1 489 359.2 488.2 361.5 487.5 361.5 486.8 362.4 486.1 362.4 485.4 362.4 484.7 363.1 483.9 363.1 483.2 363.1 482.5 363.1 481.8 364.7 480.7 364.7 480 367.2 479.3 367.2 478.6 367.9 477.8 368.8 477.1 370.4 476.4 370.4 475.7 370.4 475 373.6 474.3 375.9 473.5 375.9 472.8 375.9 472.1 375.9 471.4 375.9 470.3 375.9 469.6 375.9 468.9 378.4 468.2 378.4 467.4 379.1 466.7 379.1 466 380 465.3 380.7 464.6 383.2 463.9 387.9 463.1 390.2 462.4 391.8 461.7 392.7 461 392.7 459.9 392.7 459.2 393.4 458.5 394.3 457.8 395 457 395.9 456.3 395.9 455.6 395.9 454.9 399.1 454.2 398.4 453.4 398.4 452.7 398.4 452 398.4 451.3 398.4 450.6 398.4 449.5 398.4 448.8 399.1 448.1 400.7 447.4 401.6 446.6 401.6 445.9 401.6 445.2 402.3 444.5 402.3 443.8 403.2 443 404.8 442.3 407.1 441.6 407.1 440.9 407.1 440.2 407.1 439.1 407.1 438.4 407.1 437.7 407.1 436.9 407.1 436.2 407.1 435.5 407.1 434.8 407.1 434.1 407.1 433.4 408 432.6 408 431.9 408 431.2 408.7 430.5 409.6 429.8 411.2 428.7 412.8 428 414.4 427.3 416 426.5 416 425.8 416.7 425.1 416.7 424.4 416.7 423.7 417.6 423 417.6 422.2 417.6 421.5 418.3 420.8 418.3 420.1 419.2 419.4 419.2 418.3 419.9 417.6 419.9 416.9 420.8 416.1 420.8 415.4 420.8 414.7 420.8 414 424 413.3 424.7 412.6 425.6 411.8 425.6 411.1 426.3 410.4 427.2 409.7 427.9 409 427.9 407.9 427.2 407.2 427.2 406.5 428.8 405.7 429.5 405 431.1 404.3 431.1 403.6 431.1 402.9 431.1 402.1 432 401.4 432.6 400.7 435.2 400 441.5 399.3 441.5 398.6 441.5 397.5 441.5 396.8 441.5 396 441.5 395.3 440.6 394.6 440.6 393.9 441.5 393.2 441.5 392.5 439 391.7 437.4 391 438.3 390.3 438.3 389.6 439 388.9 439.9 388.2 440.6 387.1 441.5 386.4 441.5 385.6 441.5 384.9 441.5 384.2 441.5 383.5 441.5 382.8 441.5 382.1 441.5 381.3 441.5 380.6 441.5 379.9 441.5 379.2 441.5 378.5 441.5 377.8 441.5 376.7 441.5 376 441.5 375.2 441.5 374.5 441.5 373.8 441.5 373.1 441.5 372.4 441.5 371.7 441.5 370.9 441.5 370.2 441.5 369.5 441.5 368.8 441.5 368.1 441.5 367.3 441.5 366.3 441.5 365.6 441.5 364.8 441.5 364.1 441.5 363.4 441.5 362.7 441.5 362 441.5 361.3 441.5 360.5 441.5 359.8 441.5 359.1 441.5 358.4 441.5 357.7 441.5 356.9 441.5 355.9 441.5 355.2 441.5 354.4 441.5 353.7 441.5 353 441.5 352.3 441.5 351.6 441.5 350.8 441.5 350.1 441.5 349.4 441.5 348.7 441.5 348 441.5 347.3 441.5 346.5 441.5 345.5 441.5 344.7 441.5 344 441.5 343.3 441.5 342.6 441.5 341.9 441.5 341.2 441.5 340.4 441.5 339.7 441.5 339 441.5 338.3 441.5 337.6 441.5 336.9 441.5 336.1 441.5 335.1 441.5 334.3 441.5 333.6 441.5 332.9 441.5 332.2 441.5 331.5 441.5 330.8 441.5 330 441.5 329.3 441.5 328.6 441.5 327.9 441.5 327.2 441.5 326.5 441.5 325.7 441.5 324.7 441.5 323.9 441.5 323.2 441.5 322.5 441.5 321.8 441.5 321.1 441.5 320.4 441.5 319.6 441.5 318.9 441.5 318.2 441.5 317.5 441.5 316.8 441.5 316 439 315.3 434.2 314.3 431.1 313.5 427.9 312.8 426.3 312.1 425.6 311.4 420.8 310.7 413.5 309.9 402.3 309.2 396.6 308.5 394.3 307.8 393.4 307.1 387.9 306.4 375.9 305.6 376.8 304.9 379.1 303.9 364 303.1 351.9 302.4 343 301.7 330.3 301 319.1 300.3 312.7 299.5 304.7 298.8 300.6 298.1 292.6 297.4 284 296.7 276 296 267.1 295.2 260.7 294.5 252.7 293.4 247.9 292.7 242.2 292 234.2 291.3 230.4 290.6 226.3 289.9 222.2 289.1 215.8 288.4 212.6 287.7 211 287 207.8 286.3 206.2 285.6 207.8 284.8 207.1 284.1 207.8 283 214.2 282.3 216.7 281.6 224.7 280.9 235.2 280.2 234.2 279.5 232 278.7 232.6 278 232.6 277.3 234.2 276.6 235.8 275.9 245.4 275.1 243.8 274.4 240.6 273.7 237.4 272.6 235.8 271.9 235.2 271.2 235.8 270.5 237.4 269.8 238.3 269.1 238.3 268.3 239.9 267.6 240.6 266.9 242.2 266.2 243.1 265.5 243.8 264.7 245.4 264 247.9 263.3 252.7 262.2 257.5 261.5 257.5 260.8 260.7 260.1 261.4 259.4 263.9 258.6 267.1 257.9 270.3 257.2 271.2 256.5 271.2 255.8 279.9 255.1 286.2 254.3 286.2 253.6 287.1 252.9 287.1 251.8 287.1 251.1 286.2 250.4 285.6 249.7 285.6 249 284.6 248.2 284.6 247.5 284.6 246.8 284.6 246.1 284.6 245.4 288.7 244.7 295.1 243.9 295.8 243.2 300.6 242.5 303.1 241.4 304.7 240.7 305.4 240 306.3 239.3 306.3 238.6 308.6 237.8 308.6 237.1 308.6 236.4 308.6 235.7 308.6 235 310.2 234.3 310.2 233.5 310.2 232.8 311.1 232.1 313.6 231 313.6 230.3 313.6 229.6 314.3 228.9 314.3 228.2 315.9 227.4 315.9 226.7 318.4 226 319.1 225.3 319.1 224.6 320 223.8 320 223.1 320 222.4 320.7 221.7 321.6 220.6 322.3 219.9 323.9 219.2 325.5 218.5 325.5 217.7 325.5 217 325.5 216.3 326.4 215.6 328 214.9 328 214.2 329.6 213.4 329.6 212.7 329.6 212 329.6 211.3 329.6 210.2 330.3 209.5 330.3 208.8 331.2 208.1 332.8 207.3 333.4 206.6 338.2 205.9 342.3 205.2 345.5 204.5 346.2 203.8 347.1 203 347.8 202.3 347.8 201.6 347.8 200.9 347.8 199.8 347.8 199.1 347.8 198.4 347.8 197.7 347.8 196.9 348.7 196.2 348.7 195.5 349.4 194.8 351.9 194.1 352.6 193.4 355.1 192.6 356.7 191.9 356.7 191.2 363.1 190.5 365.6 189.4 365.6 188.7 365.6 188 365.6 187.3 367.2 186.5 368.8 185.8 368.8 185.1 369.5 184.4 370.4 183.7 370.4 183 370.4 182.2 372.7 181.5 372.7 180.8 372.7 180.1 375.2 179 375.9 178.3 377.5 177.6 378.4 176.9 378.4 176.1 379.1 175.4 380 174.7 380.7 174 380.7 173.3 380.7 172.5 380 171.8 379.1 171.1 379.1 170.4 383.2 169.7 389.5 168.6 395 167.9 396.6 167.2 396.6 166.4 396.6 165.7 396.6 165 396.6 164.3 398.4 163.6 400 162.9 404.8 162.1 404.8 161.4 405.5 160.7 405.5 160 406.4 159.3 406.4 158.2 406.4 157.5 406.4 156.8 407.1 156 408 155.3 408.7 154.6 408.7 153.9 408.7 153.2 408.7 152.5 409.6 151.7 411.2 151 411.9 150.3 413.5 149.6 414.4 148.9 415.1 147.8 415.1 147.1 415.1 146.4 416 145.6 416 144.9 420.8 144.2 422.4 143.5 424 142.8 424.7 142.1 424.7 141.3 425.6 140.6 427.2 139.9 427.2 139.2 427.2 138.5 427.2 137.4 426.3 136.7 426.3 136 426.3 135.2 426.3 134.5 426.3 133.8 426.3 133.1 426.3 132.4 426.3 131.6 426.3 130.9 427.9 130.2 428.8 129.5 430.4 128.8 432.6 128.1 434.2 127 435.2 126.3 439.9 125.5 439.9 124.8 439.9 124.1 439.9 123.4 441.5 122.7 441.5 122 439.9 121.2 439 120.5 438.3 119.8 438.3 119.1 441.5 118.4 441.5 117.7 441.5 116.6 441.5 115.9 441.5 115.1 441.5 114.4 441.5 113.7 441.5 113 441.5 112.3 441.5 111.6 441.5 110.8 441.5 110.1 441.5 109.4 441.5 108.7 441.5 108 441.5 107.3 441.5 106.2 441.5 105.5 441.5 104.7 441.5 104 441.5 103.3 441.5 102.6 441.5 101.9 441.5 101.2 441.5 100.4 441.5 99.7 441.5 99 442 721.8 442 721.8 403.9 721.1 403.9"
        />
      </g>
      <g
        id="area-swe-reveal"
        class="reveal"
      >
        <rect
          id="swe-reveal-rect"
          x="83.8"
          y="162.2"
          width="640"
          height="281.47"
        />
      </g>
  
      <g id="yAxisSWE">
        <rect
          class="area swe"
          x="43"
          y="24"
          width="311"
          height="84"
        />
        <text
          class="axis-label swe"
          transform="translate(66.8 446.8)"
        >0</text>
        <text
          class="axis-label swe"
          transform="translate(58.1 366.8)"
        >10</text>
        <text
          class="axis-label swe"
          transform="translate(58.1 286.8)"
        >20</text>
        <text
          class="axis-label swe"
          transform="translate(58.1 206.7)"
        >30</text>
        <text
          class="axis-title"
          transform="translate(54.9 57.7)"
        >Snow Water Equivalent<tspan
          x="0"
          y="32"
        >(SWE, inches)</tspan></text>
      </g>
    
      <g id="swe-annotations">
        <g class="annotation-animation-group">
          <text
            class="annotation"
            transform="translate(174 165.7)"
          >May 23rd, 2011<tspan class="cls-11"><tspan
            x="0"
            y="13.2"
          >Peak SWE of 29.3 in</tspan></tspan></text>
          
          <polyline
            class="annotation-line"
            points="284.5 202.5 266 184 171 184"
          />
          <circle
            class="annotation-line"
            cx="286.5"
            cy="205"
            r="3.5"
          />
        </g>
        <g class="annotation-animation-group">
          <text
            class="annotation"
            transform="translate(386 301.7)"
          >March 9th, 2012<tspan class="cls-11"><tspan
            x="0"
            y="13.2"
          >SWE of 12.3 in</tspan></tspan></text>
        
          <polyline
            class="annotation-line"
            points="496.5 338.5 478 320 383 320"
          />
          <circle
            class="annotation-line"
            cx="498.5"
            cy="341"
            r="3.5"
          />
        </g>
        <g class="annotation-animation-group">
          <text
            class="annotation"
            transform="translate(540 321.9)"
          >Intermittent melting</text>
        
          <polyline
            class="annotation-line"
            points="519.5 344 538 325.5 633 325.5"
          />
          <circle
            class="annotation-line"
            cx="517.4"
            cy="347.4"
            r="3.5"
          />
        </g>
      </g>
      
      <g
        id="discharge-annotations"
        class="hidden"
      >
        <text
          class="annotation discharge"
          transform="translate(326.4 176.7)"
        >Large spring melt</text>
        <g>
          <polyline
            class="annotation-line"
            points="303.9 200.1 322.4 181.6 417.4 181.6"
          />
          <circle
            class="annotation-line"
            cx="301.7"
            cy="203.5"
            r="3.5"
          />
        </g>
        <text
          class="annotation discharge"
          transform="translate(612.4 382.7)"
        >Small spring melt</text>
        <text
          class="missing-data discharge"
          transform="translate(583 454.2)"
        >missing<tspan
          x="5.8"
          y="12"
        >data</tspan></text>
        <text
          class="missing-data discharge"
          transform="translate(641 454.2)"
        >missing<tspan
          x="5.8"
          y="12"
        >data</tspan></text>
        <g>
          <polyline
            class="annotation-line"
            points="589.9 406.1 608.4 387.6 703.4 387.6"
          />
          <circle
            class="annotation-line"
            cx="587.7"
            cy="409.5"
            r="3.5"
          />
        </g>
      </g>
    </svg>
  </div>
</template>

<script>
import * as d3 from 'd3';
import { ScrollToPlugin } from "gsap/ScrollToPlugin"; // to trigger scroll events
import { ScrollTrigger } from "gsap/ScrollTrigger"; // animated scroll events

export default {
    name: "LineChart",
   
    data() {
        return {
            publicPath: process.env.BASE_URL, // this is need for the data files in the public folder, this allows the application to find the files when on different deployment roots
            d3: null,
            svg: null, // not sure
            width: null,
            height: null,
            margin: { top: 50, right: 50, bottom: 50, left: 50 },
            timeFormat: "%B",
            x: null,
            y: null,
            selectedYear: null, // this can be selected by a button

            // animation elements
            duration: 1000 // 1 second

        };
    },
    mounted (){
        this.d3 = Object.assign(d3);
        
        //insert resize here
        this.width = window.innerWidth - this.margin.left - this.margin.right;
        this.height = window.innerHeight*.5 - this.margin.top - this.margin.bottom;
        
        this.$nextTick(() => this.animateArea());
    },
    methods: {
        loadData() {
            const self=this;

            // let promises = [self.d3.csv(self.publicPath + "data/swe_and_discharge_data.csv", this.d3.autoType)]
            // Promise.all(promises).then(self.callback);
        },
        animateArea(){
          const self=this;
          this.$gsap.registerPlugin(ScrollToPlugin, ScrollTrigger); // register gsap plugins for scrollTrigger 

          // Set origins and locations
          this.$gsap.set("#swe-reveal-rect", {transformOrigin: "50% 50%"});

          // declare timeline
          let tl = this.$gsap.timeline();

          // add animations to the timeline
          tl.to("#swe-reveal-rect", {duration: 6, width: 0, x: this.width-100}); // reveal area
          tl.from(".annotation-animation-group", { duration: 1, delay: -3, opacity: 0, scale: 0.8, ease: "back", stagger: 1})

          // scroll trigger does not work yet

          // ScrollTrigger.matchMedia({
          //   // desktop
          //   "(min-width: 600px)": function() {
          //     self.$gsap.to(".swe-chart", {
          //       scrollTrigger:{
          //         trigger:".swe-chart",
          //         start: "top center",
          //         end: "bottom 80%",
          //         markers: true,
          //         toggleActions: "restart pause reverse pause",
          //         scrub: true
          //       },
          //       x: 400,
          //       rotation: 360,
          //       duration: 2
          //     })
          //   }
          // })


        },
        callback(data){
            const self=this;
            // this.sweAndDischarge = data[0];
            // console.log(this.sweAndDischarge, "swe and discharge data!")
            // console.log(this.width, this.height, "heh?")
            // set chart defaults

            // draw the chart
            // this.initChart(this.sweAndDischarge);
        }, 
        // initChart(data) {  // THIS CODE PICKS UP IN BRANCH line-chart-2 on Ellen's fork.  We can return to the interactivity later
        //     const self=this;
        //     console.log(data, "aaaand we can access the data from here too yay!")

        //     // Set dimensions of SVG for chart
        //     this.svg = this.d3.select("#swe-chart")
        //         .attr("width", this.width)
        //         .attr("height", this.height);

        //      // add a date object to each date in the array
        //     let parseTime = this.d3.timeParse("%m/%d/%Y");
        
        //     // make a copy of the dataset for editing
        //     data.forEach(function(day){
        //             day.dateObj = parseTime(day.date);
        //         })
    
        //     let filteredData = data.filter(function(day){
        //         return day.dateObj.getFullYear() === 2011 // make this a variable selected by interaction
        //     })

        //     console.log(filteredData, "what about here?")

            

        //     // create data accessors, haven't implemented them yet
        //     const yAccessor = (d) => parseInt(d.SWEin); 
        //     const xAccessor = (d) => parseTime(d.dateObj);            
            
                
        //     // Create X Axis
        //     this.xScale = this.d3.scaleTime()
        //         .domain(this.d3.extent(filteredData, function(d) { return d.dateObj; })) // calculates min and max of the array of possible dates in the filtered dataset
        //         .range([0,this.width-this.margin.left-this.margin.right]);
        //     this.xAxis = this.d3.axisBottom(this.xScale).tickFormat(this.d3.timeFormat(this.timeFormat));
        //     this.svg.append("g")
        //         .attr("transform", `translate(${this.margin.left},${this.height-this.margin.top})`)
        //         .attr("class","xAxis");       
        //     this.svg.selectAll(".xAxis")
        //         .transition()
        //         .duration(this.duration)
        //         .call(this.xAxis);


        //     // Create Y Axis
        //     this.yScale = this.d3.scaleLinear()
        //         .domain(this.d3.extent(filteredData, function(d) { return d.SWEin; }))
        //         .range([this.height-this.margin.bottom, this.margin.top]);
        //     this.yAxis = this.d3.axisLeft(this.yScale);
        //     this.svg.append("g")
        //         .attr("transform", `translate(${this.margin.left},0)`)
        //         .attr("class","yAxis");   
        //     this.svg.selectAll(".yAxis")
        //         .transition()
        //         .duration(this.duration)
        //         .call(this.yAxis);    

        //     // Create Second Y Axis for Discharge
        //     this.yScaleDisch = this.d3.scaleLinear()
        //         .domain(this.d3.extent(filteredData, function(d) { return d.discharge; }))
        //         .range([this.height-this.margin.bottom, this.margin.top]);
        //     this.yAxisDisch = this.d3.axisRight(this.yScaleDisch);
        //     this.svg.append("g")
        //         .attr("transform", `translate(${this.width-this.margin.right},0)`)
        //         .attr("class","yAxisDisch");   
        //     this.svg.selectAll(".yAxisDisch")
        //         .transition()
        //         .duration(this.duration)
        //         .call(this.yAxisDisch);    
               
        //     // Create an update selection: bind to the data
        //     let lineGroup = this.svg.append("g")
        //         .attr("class","line-group")
        //         .attr("transform", `translate(${this.margin.left},0})`);
            
        //     // create groups for each line
        //     let groupedData = [{
        //         key: "discharge",
        //         values: []
        //         },{
        //         key: "SWEin",
        //         values: []
        //         }
        //     ];
        //     filteredData.forEach(function (day){
        //         var todaysDischarge = {
        //             dateObj: day.dateObj,
        //             n: day.discharge
        //         }
        //         var todaysSWE = {
        //             dateObj: day.dateObj,
        //             n: day.SWEin
        //         }
        //         // groupedData[0].values.push(todaysDischarge);
        //         groupedData[1].values.push(todaysSWE);
        //     })        
  
        //     // Update Line
        //     lineGroup.selectAll(".line")
        //         .data(groupedData)
        //         .enter()
        //         .append("path")
        //             .attr("class","line")
        //             .attr("fill", "none")
        //             .attr("stroke", "coral")
        //             .attr("stroke-width", 1) 
        //             .attr("d", function(d){
        //                 return d3.line()
        //                     // .curve(this.d3.curveMonotoneX)
        //                     .x(function(d) { return self.xScale(d.dateObj)})
        //                     .y(function(d) { return self.yScale(d.n)})
        //                     (d.values)
        //             });
        //         // .merge()
        //         // .transition()
        //         // .duration(this.duration);
                
        //     // add annotation
            
        //     // find date of peak swe
           
        //     // let peakSWE = filteredData.reduce((acc, day) => {
        //     //     return acc + day.SWEin;
        //     // });
        //     let peakSWE = Math.max.apply(Math.filteredData.map(function(o){return o.SWEin;}));
        //     console.log(peakSWE,"Peak")
            

        // }
    }
}
</script>

<style lang="scss" scoped>
    svg {
        width: 800px;
        height: 500px;
    }

   .axis-tick, .annotation-line {
        fill: none;
        stroke: #d9d9d9;
        stroke-width: 0.75px;
        stroke-linejoin: round;
      }

    .axis-label {
        font-size: 12px;
        font-weight: 300;
    }

    .axis-title {
        font-family: SourceSansPro-Black, Source Sans Pro;
        font-weight: 800;
        fill: #fff;
        font-size: 26px;
    }
    .reveal {
      rect {
        fill: white;
      }
    }

    .area{
        stroke-linejoin: round;
        stroke-linecap: round;
        stroke-width: 2px;
    }

    .swe{
        fill: black;
    }
    
    .discharge {
        fill: #43a1ff;
        
    }

    .hidden {
        display: none;
    }
    .annotation {
        font-size: 11px;
        .emph {

        }
    }

    .missing-data {
        font-size: .8em;
        font-style: italic;
    }

      .cls-6 {
        stroke-linejoin: round;
      }

      .cls-2 {
        font-size: 12px;
      }

      .cls-2 {
        fill: #595959;
      }

      .cls-13, .cls-2 {
        font-family: SourceSansPro-LightItalic, Source Sans Pro;
        font-style: italic;
      }      
    
 
</style>

